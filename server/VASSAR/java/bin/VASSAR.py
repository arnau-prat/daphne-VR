import os
import jpype

class VASSAR:

    libs = ''.join([":./VASSAR/java/"+f for f in os.listdir('./VASSAR/java/') if f.endswith('.jar')])

    rbsaeoss = None

    def __init__(self):
        # Start JVM
        if not jpype.isJVMStarted():
            jpype.startJVM(jpype.getDefaultJVMPath(),'-ea','-Djava.class.path=./VASSAR/java/bin/'+self.libs)
       	# Get RBSAEOSS class
        rbsaPkg = jpype.JPackage('rbsa').eoss.local
        RBSAEOSS = rbsaPkg.RBSAEOSS
        self.rbsaeoss = RBSAEOSS()

    def evaluateArch(self,orbits):
        jpype.attachThreadToJVM()
        input_arch = jpype.java.util.ArrayList()
        for o in orbits:
            input_arch.add(o)
        result = self.rbsaeoss.evaluateArch(input_arch)
        return result

    def criticizeArch(self,orbits):
        jpype.attachThreadToJVM()
        input_arch = jpype.java.util.ArrayList()
        for o in orbits:
            input_arch.add(o)
        result = self.rbsaeoss.criticizeArch(input_arch)
        output_res = []
        for r in result:
            output_res.append(str(r))
        output_res = self.convertOutput(output_res)
        return output_res

    def explainArch(self,orbits):
       return ""

    def improveArch(self,orbits):
       return ""

    def convertOutput(self, output_res):
        for r in range(0, len(output_res)):
            # Instruments
            output_res[r] = output_res[r].replace("ACE_ORCA","A")
            output_res[r] = output_res[r].replace("ACE_POL","B")
            output_res[r] = output_res[r].replace("ACE_LID","C")
            output_res[r] = output_res[r].replace("CLAR_ERB","D")
            output_res[r] = output_res[r].replace("ACE_CPR","E")
            output_res[r] = output_res[r].replace("DESD_SAR","F")
            output_res[r] = output_res[r].replace("DESD_LID","G")
            output_res[r] = output_res[r].replace("GACM_VIS","H")
            output_res[r] = output_res[r].replace("GACM_SWIR","I")
            output_res[r] = output_res[r].replace("HYSP_TIR","J")
            output_res[r] = output_res[r].replace("POSTEPS_IRS","K")
            output_res[r] = output_res[r].replace("CNES_KaRIN","L")
            # Orbits
            output_res[r] = output_res[r].replace("LEO-600-polar-NA","1")
            output_res[r] = output_res[r].replace("SSO-600-SSO-AM","2")
            output_res[r] = output_res[r].replace("SSO-600-SSO-DD","3")
            output_res[r] = output_res[r].replace("SSO-800-SSO-DD","4")
            output_res[r] = output_res[r].replace("SSO-800-SSO-PM","5")

        return output_res

    def close(self):
        jpype.shutdownJVM()
