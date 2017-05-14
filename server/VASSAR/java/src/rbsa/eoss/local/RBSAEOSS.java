package rbsa.eoss.local;

import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Stack;

import rbsa.eoss.Architecture;
import rbsa.eoss.ArchitectureEvaluator;
import rbsa.eoss.ArchitectureGenerator;
import rbsa.eoss.Result;
import rbsa.eoss.ResultCollection;
import rbsa.eoss.ResultManager;
import rbsa.eoss.DBManagement;

/**
 *
 * @author Arnau
 */

// Instruments equivalence:
// A - ACE_ORCA
// B - ACE_POL
// C - ACE_LID
// D - CLAR_ERB
// E - ACE_CPR
// F - DESD_SAR
// G - DESD_LID
// H - GACM_VIS
// I - GACM_SWIR
// J - HYSP_TIR
// K - POSTEPS_IRS
// L - CNES_KaRIN
// Orbits equivalences:
// 1 - LEO-600-polar-NA
// 2 - SSO-600-SSO-AM
// 3 - SSO-600-SSO-DD
// 4 - SSO-800-SSO-DD
// 5 - SSO-800-SSO-PM

// javac -d bin -cp "Test.jar:./*" -sourcepath src src/rbsa/eoss/local/RBSAEOSS.java
// java -cp .:../*  rbsa.eoss.local.RBSAEOSS

public class RBSAEOSS {

    private String path = "/home/ubuntu/daphne-VR/server/VASSAR/";

    private ArchitectureEvaluator AE = null;
    private ArchitectureGenerator AG = null;

    private String search_clps = "";
    private Params params = null;

    public RBSAEOSS() {
        // Initialization
        AE = ArchitectureEvaluator.getInstance();
        AG = ArchitectureGenerator.getInstance();
        params = new Params(path, "FUZZY-ATTRIBUTES", "test","normal",search_clps); //FUZZY or CRISP
        AE.init(1);
    }

    public double[] evaluateArch(ArrayList<String> input_arch) {
        // Generate a new architecture
        Architecture architecture = AG.defineNewArch(input_arch);
        // Evaluate the architecture
        Result result = AE.evaluateArchitecture(architecture, "slow");
        // Return the score and the cost
        double[] res = {result.getScience(), result.getCost()};
        return res;
    }

    // NEW !!!
    public String[] criticizeArch(ArrayList<String> input_arch) {
        // Generate a new architecture
        Architecture architecture = AG.defineNewArch(input_arch);
        // Criticize the architecture
        Result result = AE.criticizeArchitecture(architecture, "complete"); //COMPLETE or PARTIALLY
        // Return the explanation
        String[] res = result.getCritic();
        return res;
    }

    public String improveArch() {

        String res = "hello";
        return res;

    }

    public static void main(String[] args) {

        System.out.println("RBSAEOSS class");
        System.exit(0);
    }
}
