package rbsa.eoss.local;

import java.io.BufferedReader;
import java.io.FileReader;
import rbsa.eoss.Architecture;
import rbsa.eoss.ArchitectureEvaluator;
import rbsa.eoss.ArchitectureGenerator;
import rbsa.eoss.Result;
import rbsa.eoss.ResultCollection;
import rbsa.eoss.ResultManager;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Random;
import java.util.Stack;
import rbsa.eoss.DBManagement;

// javac -d bin -cp "Test.jar:./*" -sourcepath src src/rbsa/eoss/local/RBSAEOSS.java
// java -cp .:../*  rbsa.eoss.local.RBSAEOSS

public class RBSAEOSS { 

    public static String evaluateArch(String... orbits) {

        return "hello";
    }

    public static String criticizeArch(String... orbits) {

        return "hello";

    }

    public static String imporveArch(String... orbits) {

        return "hello";

    }

    public static void main(String[] args){
        
    // Set a path to the project folder
    String path = "/Users/arnauprat/Desktop/RBSAEOSS";
    
    // Initialization
    ArchitectureEvaluator AE = ArchitectureEvaluator.getInstance();
    ArchitectureGenerator AG = ArchitectureGenerator.getInstance();
    ResultManager RM = ResultManager.getInstance();
    
    Params params = null;
    String search_clps = "";
    
    params = new Params(path, "FUZZY-ATTRIBUTES", "test","normal",search_clps); //FUZZY or CRISP

    AE.init(1);

    // Configure the database
    // DBManagement dbm = new DBManagement();
    // Initialize the database
    // dbm.createNewDB();
    // dbm.encodeRules();

    //////////////////////////////////////////////////////////////////////////////////////////////////
    //////////////////////////////// Evaluate single architecture ////////////////////////////////////
    ////////////////////////////////////////////////////////////////////////////////////////////////// 
        
    long t0 = System.currentTimeMillis();

    // Input a new architecture design
    // There must be 5 orbits. Instrument name is represented by a capital letter, taken from {A,B,C,D,E,F,G,H,I,J,K,L}
    ArrayList<String> input_arch = new ArrayList<>();
    String orbit_1 = "ABCDLH"; input_arch.add(orbit_1);
    String orbit_2 = "AKDFG"; input_arch.add(orbit_2);
    String orbit_3 = "ALBGH"; input_arch.add(orbit_3);
    String orbit_4 = "ADCLE"; input_arch.add(orbit_4);
    String orbit_5 = "BHKELJ"; input_arch.add(orbit_5);
    // String orbit_1 = "ABCDLH"; input_arch.add(orbit_1);
    // String orbit_2 = "AKDFG"; input_arch.add(orbit_2);
    // String orbit_3 = "ALBGH"; input_arch.add(orbit_3);
    // String orbit_4 = "ADCLE"; input_arch.add(orbit_4);
    // String orbit_5 = "BHKELJ"; input_arch.add(orbit_5);
    // Generate a new architecture
    Architecture architecture = AG.defineNewArch(input_arch);
        
    // Architecture architecture = AG.getMaxArch2();
    
    // Evaluate the architecture
    Result result = AE.evaluateArchitecture(architecture,"Slow");
        
    // Save the score and the cost
    double cost = result.getCost();
    double science = result.getScience();
        
    System.out.println("Performance Score: " + science + ", Cost: " + cost);
            
    long t1 = System.currentTimeMillis();
    System.out.println( "Evaluation done in: " + String.valueOf(t1-t0) + " msec");
        
    System.out.println("Done");

    System.exit(0);

    }
}
