import csv
import json
import numpy as np
from sqlalchemy.orm import sessionmaker

import models

class CRITIC:

    # Connect to the CEOS database
    engine = models.db_connect()
    session = sessionmaker(bind=engine)()

    orbitsDataset = [
        {"alias": "1", "name": "LEO-600-polar-NA", "type": "Inclined, non-sun-synchronous","altitude": 600,"LST":""},
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
                models.Mission.orbit_altitude.between(orbit["altitude"]-50, orbit["altitude"]+50))) \
            .filter(models.Instrument.missions.any( \
                models.Mission.orbit_LST == orbit["LST"]))
        # Return result
        result = query.all()
        return result

    # Used to compute CRITIC2.csv

    def orbitsSimilarity(self, orbit1, mission2):
        score = 0
        # Score orbit type
        if orbit1["type"] == mission2.orbit_type:
            score += 1
        # Score orbit altitude
        if orbit1["altitude"]-50 < mission2.orbit_altitude < orbit1["altitude"]+50:
            score += 1
        # Score orbit LST
        if orbit1["LST"] == mission2.orbit_LST:
            score += 1
        # Return orbit score
        return score

    def instrumentsScore(self, instrument1, instrument2):
        score = 0.0
        # Score instrument type
        for type2 in instrument2.types:
            if instrument1["type"] == type2.name:
                score += 1
                break
        # Score instrument technology
        if instrument1["technology"] == instrument2.technology:
            score += 1
        # Score instrument geometry
        for geometry2 in instrument2.geometries:
            if instrument1["geometry"] == geometry2.name:
                score += 1
                break
        # Score instrument wavebands
        for waveband1 in instrument1["wavebands"]:
            for waveband2 in instrument2.wavebands:
                if waveband1 == waveband2.name:
                    score += 1/len(instrument1["wavebands"])
                    break
        # Return instruments score
        return score

    def instrumentsSimilarity(self, instruments1, instruments2):
        score = 0.0
        # Compute similarity matrix
        N = max(len(instruments1),len(instruments2))
        sim = np.zeros((N,N))
        for i1 in range(len(instruments1)):
            for i2 in range(len(instruments2)):
                sim[i1,i2] = self.instrumentsScore(instruments1[i1],instruments2[i2])
        # Find the best matches for i1xi2 (greedy)
        for k in range(len(instruments1)):
            i1i2 = np.argmax(sim)
            i1 = i1i2 / N
            i2 = i1i2 % N
            score += sim[i1,i2]/len(instruments1)
            sim[i1,:] = 0
            sim[:,i2] = 0
        return score

    def instrumentsMatchDataset(self, instruments2):
        matches = []
        instruments1 = self.instrumentsDataset
        N = len(instruments1)
        M = len(instruments2)
        # Compute similarity matrix
        sim = np.zeros((N,M))
        for i1 in range(N):
            for i2 in range(M):
                sim[i1,i2] = (self.instrumentsScore(instruments1[i1],instruments2[i2])*10)/4
        # Find the best matches for i2
        for i2 in range(M):
            i1i2 = np.argmax(sim[:,i2])
            i1 = i1i2 % N
            matches.append([instruments1[i1]["alias"],instruments2[i2].name,sim[i1,i2]])
        return matches

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
                score += self.instrumentsSimilarity(instruments1, mission2.instruments)
            if score > maxScore:
                maxScore = score
                maxMission = mission2
        # Return result
        return [(maxScore*10)/7, maxMission]

    def matchFeatures(self, arch):
        res = []
        with open("EOSS_features.csv", "r") as csvfile:
            features = csv.reader(csvfile, delimiter=':')
            for row in features:
                match = True
                # present
                for i in row[0]:
                    if not any(i in o for o in arch):
                        match = False
                # abscent
                for i in row[1]:
                    if any(i in o for o in arch):
                        match = False
                # inOrbit
                inOrbit = json.loads(row[2])
                for o in range(len(inOrbit)):
                    for i in inOrbit[o]:
                        if not i in arch[o]:
                            match = False
                # notInOrbit
                notInOrbit = json.loads(row[3])
                for o in range(len(notInOrbit)):
                    for i in notInOrbit[o]:
                        if i in arch[o]:
                            match = False
                # together
                if len(row[4]) > 1:
                    for o in range(len(arch)):
                        if row[4][0] in arch[o]:
                            if not [c in arch[o] for c in row[4]]:
                                match = False
                # togetherInOrbit
                rr = json.loads(row[5])
                if int(rr[1]) > 0:
                    if len(rr[0]) > 1:
                        if rr[0] in arch(int(rr[1]-1)):
                            if not [c in arch[int(rr[1]-1)] for c in rr[0]]:
                                match = False
                # separate
                if len(row[6]) > 1:
                    for o in range(len(arch)):
                        print row[6]
                        if row[6][0] in arch(o):
                           if [c in arch[o] for c in row[6]]:
                               match = False
                # emptyOrbit
                emptyOrbit = int(row[7])-1
                if emptyOrbit > -1:
                    if arch[emptyOrbit] != '':
                        match = False
                # numberOfOrbitsUsed
                numberOfOrbitsUsed = int(row[8])
                if numberOfOrbitsUsed != -1:
                    if sum(o != '' for o in arch) != numberOfOrbitsUsed:
                        match = False
                print match
                # numberOfInstruments
                numberOfInstruments = int(row[9])
                if numberOfInstruments != -1:
                    if sum(i for i in o for o in arch) != numberOfInstruments:
                        match = False
                # Append res if match == True
                if match == True:
                    res.append(row)
        return res

    def p(self, l):
        if not l: return [[]]
        return self.p(l[1:]) + [[l[0]] + x for x in self.p(l[1:])]


    def generateCritic1(self):
        out_filename = "CRITIC1.csv"
        f = open(out_filename, 'w')
        # For each instrument in each possible orbit (5*12=60)
        for orbit in self.orbitsDataset:
            for instrument in self.instrumentsDataset:
                # Get similar instruments from the database
                result = self.getSimilarInstruments(orbit, instrument)
                # Write results to the output file
                f.write(orbit["alias"]+"\t"+instrument["alias"]+"\t"+str(len(result))+"\t"+str([r.name for r in result])+"\n")
        f.close()


    def generateCritic2(self):
        out_filename = "CRITIC2.csv"
        f = open(out_filename, 'w')
        # Get missions in the database
        missionsDatabase = self.session.query(models.Mission)
        # For each combination of instruments in each possible orbit ((2^12)*5 = 20480)
        for orbit1 in self.orbitsDataset:
            for instruments1 in self.p(self.instrumentsDataset):
                # Get similar missions from the database
                result = self.missionsSimilarity(orbit1, instruments1, missionsDatabase)
                # Write results to the output file
                if result["maxScore"] != -1:
                    f.write(orbit1["alias"]+"\t"+str(sorted([i["alias"] for i in instruments1]))+"\t"+result[1].name+"\t"+str(result[0])+"\n")
        f.close()

    def criticizeArch(self, arch):
        result = []
        # Type 1: Instrument by intrument
        #for o in range(len(arch)):
        #    for i in arch[o]:
        #        orbit = self.orbitsDataset[o]
        #        instrument = next(ii for ii in self.instrumentsDataset if ii["alias"] == i)
        #        res = self.getSimilarInstruments(orbit, instrument)
        #        if len(res) == 0:
        #            result.append([
        #                "historian1",
        #                "Instrument %s has never been flown in orbit %s before" % \
        #                     (instrument["alias"], orbit["alias"])
        #            ])
        #        else:
        #            result.append([
        #                "historian1",
        #                "Instrument %s has been flown in orbit %s before (%s matches in the database)" % \
        #                    (instrument["alias"], orbit["alias"], len(res)),
        #                str(', '.join([r.name for r in res]))
        #        ])
        # Type 2: Mission by mission
        missionsDatabase = self.session.query(models.Mission)
        for o in range(len(arch)):
            orbit = self.orbitsDataset[o]
            instruments = [next(ii for ii in self.instrumentsDataset if ii["alias"] == i) for i in arch[o]]
            res = self.missionsSimilarity(orbit, instruments, missionsDatabase)
            if len(instruments) > 0:
                if res[0] < 6:
                    result.append([
                        "historian2",
                        "There are no similar missions to %s in orbit %s in the database" % \
                            (str([i["alias"] for i in instruments]), orbit["alias"])
                    ])
                else:
                    result.append([
                        "historian2",
                        "The most similar mission to %s in orbit %s is %s (score: %.2f/10)" % \
                            (str([i["alias"] for i in instruments]), orbit["alias"], res[1].name, res[0]),
                        '<br>'.join(["Instrument similar to %s (score: %.2f)" % \
                            (i[0], i[2]) for i in self.instrumentsMatchDataset(res[1].instruments)])
                    ])
        # Analyst
        if len(''.join(arch)) > 0:
            res = self.matchFeatures(arch)
            if len(res) == 0:
                result.append([
                    "analyst",
                    "There doesn't seem to be any good features in your design"
                ])
            else:
                result.append([
                    "analyst",
                    "There seems to be %d good features in your design" % len(res),
                    '<br>'.join(["Feature %s" % r for r in res])
                ])
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
