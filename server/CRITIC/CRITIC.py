from sqlalchemy import func
from sqlalchemy.orm import sessionmaker

import models

class CRITIC:

    # Connect to the CEOS database
    engine = models.db_connect()
    session = sessionmaker(bind=engine)()

    orbitsDataset = [
        {"alias": "1", "name": "LEO-600-polar-NA", "type": "Inclined, non-sun-synchronous","altitude": 600,"LST":"ANY"},
        {"alias": "2", "name": "SSO-600-SSO-AM", "type": "Sun-synchronous", "altitude": 600, "LST": "AM"},
        {"alias": "3", "name": "SSO-600-SSO-DD", "type": "Sun-synchronous", "altitude": 600, "LST": "DD"},
        {"alias": "4", "name": "SSO-800-SSO-DD", "type": "Sun-synchronous", "altitude": 800, "LST": "DD"},
        {"alias": "5", "name": "SSO-800-SSO-PM", "type": "Sun-synchronous", "altitude": 800, "LST": "PM"}]

    instrumentsDataset = [
        {"alias": "A", "name": "ACE_ORCA", "type": "Ocean colour instruments", "technology": "Medium-resolution spectro-radiometer", "geometry": "Cross-track scanning", "wavebands": ["UV","VIS","NIR","SWIR"]},
        {"alias": "B", "name": "ACE_POL", "type": "Multiple direction/polarisation radiometers", "technology": "Multi-channel/direction/polarisation radiometer", "geometry": "ANY", "wavebands": ["VIS","NIR","SWIR"]},
        {"alias": "C", "name": "ACE_LID", "type": "Lidars", "technology": "Atmospheric lidar", "geometry": "Nadir-viewing", "wavebands": ["VIS","NIR"]},
        {"alias": "D", "name": "CLAR_ERB", "type": "Hyperspectral imagers", "technology": "Multi-purpose imaging Vis/IR radiometer", "geometry": "Nadir-viewing", "wavebands": ["VIS","NIR","SWIR","TIR","FIR"]},
        {"alias": "E", "name": "ACE_CPR", "type": "Cloud profile and rain radars", "technology": "Cloud and precipitation radar", "geometry": "Nadir-viewing", "wavebands": ["MW"]},
        {"alias": "F", "name": "DESD_SAR", "type": "Imaging microwave radars", "technology": "Imaging radar (SAR)", "geometry": "Side-looking", "wavebands": ["MW","L-Band","S-Band"]},
        {"alias": "G", "name": "DESD_LID", "type": "Lidars", "technology": "Lidar altimeter", "geometry": "ANY", "wavebands": ["NIR"]},
        {"alias": "H", "name": "GACM_VIS", "type": "Atmospheric chemistry", "technology": "High-resolution nadir-scanning IR spectrometer", "geometry": "Nadir-viewing", "wavebands": ["UV","VIS"]},
        {"alias": "I", "name": "GACM_SWIR", "type": "Atmospheric chemistry", "technology": "High-resolution nadir-scanning IR spectrometer", "geometry": "Nadir-viewing", "wavebands": ["SWIR"]},
        {"alias": "J", "name": "HYSP_TIR", "type": "Imaging multi-spectral radiometers (vis/IR)", "technology": "Medium-resolution IR spectrometer", "geometry": "Whisk-broom scanning", "wavebands": ["MWIR", "TIR"]},
        {"alias": "K", "name": "POSTEPS_IRS", "type": "Atmospheric temperature and humidity sounders", "technology": "Medium-resolution IR spectrometer", "geometry": "Cross-track scanning", "wavebands": ["MWIR", "TIR"]},
        {"alias": "L", "name": "CNES_KaRIN", "type": "Radar altimeters", "technology": "Radar altimeter", "geometry": "Nadir-viewing", "wavebands": ["MW", "Ku-Band"]}]

    # Used to compute CRITIC1.csv

    def getSimilarInstruments(self, orbit, instrument):
        # Get instruments with similar characteristics and similar orbits
        query = self.session.query(models.Instrument) \
            .filter(models.Instrument.types.any(models.InstrumentType.name == instrument["type"])) \
            .filter(models.Instrument.technology == instrument["technology"]) \
            .filter(models.Instrument.geometries.any(models.GeometryType.name == instrument["geometry"])) \
            .filter(models.Instrument.wavebands.any(models.Waveband.name.in_(instrument["wavebands"]))) \
            .filter(models.Instrument.missions.any( \
                models.Mission.orbit_type == orbit["type"])) \
            .filter(models.Instrument.missions.any( \
                models.Mission.orbit_altitude.between(orbit["altitude"]-50, orbit["altitude"]+50)))
        # Return result
        result = query.all()
        return result

    # Used to compute CRITIC2.csv

    def orbitsSimilarity(self, orbit1, mission2):
        score = 0
        # Score orbit type
        if orbit1["type"] == mission2.orbit_type:
            score += 1
        # Score altitude type
        if orbit1["altitude"]-50 < mission2.orbit_altitude < orbit1["altitude"]+50:
            score += 1
        # Return orbit score
        return score

    def instrumentsSimilarity(self, instruments1, mission2):
        score = 0.0
        for instrument1 in instruments1:
            for instrument2 in mission2.instruments:
                # Score instruments type
                for type2 in instrument2.types:
                    if instrument1["type"] == type2.name:
                        score += 1/len(instrument2.types)
                # Score instruments technology
                if instrument1["technology"] == instrument2.technology:
                    score += 1
                # Score instruments geometry
                for geometry2 in instrument2.geometries:
                    if instrument1["geometry"] == geometry2.name:
                        score += 1/len(instrument2.geometries)
                # Score instruments wavebands
                for waveband2 in instrument2.wavebands:
                    for waveband1 in instrument1["wavebands"]:
                        if waveband1 == waveband2.name:
                            score += 1/(len(instrument2.wavebands)*len(instrument1["wavebands"]))
                # Divide by i1*i2
                score = score/(len(instruments1)*len(mission2.instruments))
        # Return instruments score
        return score

    def missionsSimilarity(self, orbit1, instruments1, missionsDatabase):
        maxScore = -1
        maxMission = None
        # Iterate over all the missions in the database
        for mission2 in missionsDatabase:
            score = 0
            # Get orbits similarity
            score += self.orbitsSimilarity(orbit1, mission2)
            # If score bigger than a threshold
            if(score > 1):
                # Get instruments similarities
                score += self.instrumentsSimilarity(instruments1, mission2)
            if score > maxScore:
                maxScore = score
                maxMission = mission2
        # Return result
        return {"maxScore": maxScore, "maxMission": maxMission}

    def p(self, l):
        if not l: return [[]]
        return self.p(l[1:]) + [[l[0]] + x for x in self.p(l[1:])]


    def generateCritic1(self):
        out_filename = "CRITIC1.csv"
        f = open(out_filename, 'w')
        # For each instrument in each possible orbit (5*12=60)
        for orbit in self.orbitsDataset:
            for instrument in self.instrumentsDataset:
                # Get similar instruments used in similar orbits
                result = self.getSimilarInstruments(orbit, instrument)
                # Write results to the output file
                f.write(orbit["alias"]+":"+instrument["alias"]+":"+str(len(result))+":"+str([r.name for r in result])+"\n")
        f.close()


    def generateCritic2(self):
        out_filename = "CRITIC2.csv"
        f = open(out_filename, 'w')
        # Get missions in the database
        missionsDatabase = self.session.query(models.Mission)
        # For each combination of instruments in each possible orbit ((2^12)*5 = 20480)
        for orbit1 in self.orbitsDataset:
            for instruments1 in self.p(self.instrumentsDataset):
                result = self.missionsSimilarity(orbit1, instruments1, missionsDatabase)
                # Write results to the output file
                if result["maxScore"] != -1:
                    f.write(orbit1["alias"]+":"+str(sorted([i["alias"] for i in instruments1]))+":"+result["maxMission"].name+":"+str(result["maxScore"])+"\n")
        f.close()

    def criticizeArch(self, arch):
        result = []
        # Type 1: Instrument by intrument
        for o in range(len(arch)):
            for i in arch[o]:
                orbit = self.orbitsDataset[o]
                instrument = next(ii for ii in self.instrumentsDataset if ii["alias"] == i)
                res = self.getSimilarInstruments(orbit, instrument)
                result.append("== Instrument "+instrument["alias"]+" in orbit "+orbit["alias"]+": "+ \
                    str(len(res))+" matches"+" %s" % \
                    (": "+", ".join([r.name for r in res[:2]])+("..." if len(res) > 1 else "") if len(res) > 0 else ""))
        # Type 2: Mission by mission
        missionsDatabase = self.session.query(models.Mission)
        for o in range(len(arch)):
            orbit = self.orbitsDataset[o]
            instruments = [next(ii for ii in self.instrumentsDataset if ii["alias"] == i) for i in arch[o]]
            res = self.missionsSimilarity(orbit, instruments, missionsDatabase)
            if len(instruments) > 0:
                result.append("== The most similar mission to "+str([i["alias"] for i in instruments])+" in orbit "+ \
                    orbit["alias"]+" is "+str(res["maxMission"].name)+ " with a score of "+str(res["maxScore"]))
        # Return result
        return result

def main():
    print "Do nothing"
    #critic = CRITIC()
    #print "Generating CRITIC1.csv"
    #critic.generateCritic1()
    #print "Generating CRITIC2.csv"
    #critic.generateCritic2()

if __name__ == '__main__':
    main()
