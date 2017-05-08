

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package rbsa.eoss;

//import be.ac.ulg.montefiore.run.jadti.AttributeSet;
//import be.ac.ulg.montefiore.run.jadti.AttributeValue;
//import be.ac.ulg.montefiore.run.jadti.DecisionTree;
//import be.ac.ulg.montefiore.run.jadti.Item;
//import be.ac.ulg.montefiore.run.jadti.ItemSet;
//import be.ac.ulg.montefiore.run.jadti.KnownSymbolicValue;
//import be.ac.ulg.montefiore.run.jadti.SymbolicAttribute;
//import be.ac.ulg.montefiore.run.jadti.SymbolicValue;
//import be.ac.ulg.montefiore.run.jadti.UnknownSymbolicValue;
import java.util.ArrayList;
import java.util.Comparator;
import java.util.List;
import java.util.Vector;
import java.util.Random;
import rbsa.eoss.local.Params;
import java.io.File;
import java.awt.BorderLayout;
import java.util.Arrays;
import javax.swing.JFrame;
/**
 *
 * @author Bang
 */
public class DrivingFeaturesGenerator {
    private static DrivingFeaturesGenerator instance = null;
    
    private ArrayList<Architecture> focus;
    private ArrayList<Architecture> random;
    private ArrayList<int[][]> focusData;
    private ArrayList<int[][]> randomData;
    private int[][] dataFeatureMat;
    private double supp_threshold;
    private double confidence_threshold;
    private double lift_threshold;
    
    private double ninstr;
    private double norb;
    
    private ArrayList<DrivingFeature> drivingFeatures;
    private ArrayList<DrivingFeature> userDef;
    


     
    
    public void initialize(ArrayList<Architecture> focus, ArrayList<Architecture> random, double supp, double conf, double lift){
       
        this.focus = focus;
        this.random = random;
        this.supp_threshold=supp;
        this.confidence_threshold=conf;
        this.lift_threshold=lift;
        
        focusData = new ArrayList<>();
        randomData = new ArrayList<>();
        
        for (Architecture arch : focus) {
            focusData.add(booleanToInt(arch.getMat()));
        }
        for (Architecture arch2 : random) {
            randomData.add(booleanToInt(arch2.getMat()));
        }

        this.ninstr = focus.get(0).getNinstr();
        this.norb = focus.get(0).getNorb();
        
        userDef = new ArrayList<>();
        
    }
    public void initialize2(ArrayList<int[][]> focus, ArrayList<int[][]> random, double supp, double conf, double lift){
       
        
//        this.focus = focus;
//        this.random = random;
        this.supp_threshold=supp;
        this.confidence_threshold=conf;
        this.lift_threshold=lift;
        
        this.focusData = focus;
        this.randomData = random;
        
        this.ninstr = focusData.get(0)[0].length;
        this.norb = focusData.get(0).length;
        
        userDef = new ArrayList<>();
        drivingFeatures = new ArrayList<>();

    }
    
    
    private double computeLift (Scheme scheme) {
        
        int count_focus = 0;
        int count_random = 0;
        for (int[][] e : focusData) {
            if (scheme.compare(e, "") == 1) ++count_focus;
        }
        for (int[][] e : randomData) {
            if (scheme.compare(e, "") == 1) ++count_random;
        }
        double lift =0;
        if (count_random != 0) lift = (double) ( (double) count_focus/focusData.size())/ ( (double) count_random/randomData.size());
        
        return lift;
    }
    
    private double computeSupport (Scheme scheme) {
        
        int count_data = 0;
        for (int[][] e : focusData) {
            if (scheme.compare(e, "") == 1) count_data++;
        }
        double support = ((double) count_data)/((double)randomData.size());
        return support;
    }
    
    private double computeConfidenceGivenSelection (Scheme scheme){
        int count_focus=0;
        int count_random=0;
        int focus_size = focusData.size();

        for (int[][] e : focusData) {
            if (scheme.compare(e, "") == 1) count_focus++;
        }
        for (int[][] e : randomData) {
            if (scheme.compare(e, "") == 1) count_random++;
        }
        double conf = (double) ((double) count_focus)/((double) focusData.size());   // confidence of a rule  {goodDesign} -> {feature}

        return conf;
    }
    private double computeConfidenceGivenFeature (Scheme scheme) {
        
//        randomData
//        focusData;        
        int count_focus=0;
        int count_random=0;
        int focus_size = focusData.size();

        for (int[][] e : focusData) {
            if (scheme.compare(e, "") == 1) count_focus++;
        }
        for (int[][] e : randomData) {
            if (scheme.compare(e, "") == 1) count_random++;
        }
        double conf = (double) ((double) count_focus)/((double) count_random);   // confidence of a rule  {feature} -> {goodDesign}

        return conf;
    } 

    public ArrayList<DrivingFeature> getDrivingFeatures (){

        Scheme scheme = new Scheme();

        scheme.setName("present");
        for (int i = 0; i < ninstr; ++i) {
            scheme.setInstrument (i);
            double support = computeSupport (scheme);
            double lift = computeLift(scheme);
            double conf = computeConfidenceGivenFeature(scheme);
            double conf2 = computeConfidenceGivenSelection(scheme);
            if (support > supp_threshold && lift > lift_threshold && conf > confidence_threshold && conf2 > confidence_threshold) {
                String[] param = new String[1];
                param[0] = Params.instrument_list[i];
                String featureName = "present[" + param[0] + "]";
                drivingFeatures.add(new DrivingFeature(featureName,"present", param, lift, support, conf, conf2));
            }
        }
        scheme.setName("absent");
        for (int i = 0; i < ninstr; ++i) {
            scheme.setInstrument (i);
            double support = computeSupport (scheme);
            double lift = computeLift(scheme);
            double conf = computeConfidenceGivenFeature(scheme);
            double conf2 = computeConfidenceGivenSelection(scheme);
            if (support > supp_threshold && lift> lift_threshold && conf > confidence_threshold && conf2 > confidence_threshold) {
                String [] param = new String[1];
                param[0] = Params.instrument_list[i];
                String featureName = "absent[" + param[0] + "]";
                drivingFeatures.add(new DrivingFeature(featureName,"absent", param, lift, support, conf, conf2));
            }
        }
        scheme.setName("inOrbit");
        for (int i = 0; i < norb; ++i) {
            for (int j = 0; j < ninstr; ++j) {
                scheme.setInstrument (j);
                scheme.setOrbit(i);
                double support = computeSupport (scheme);
                double lift = computeLift(scheme);
                double conf = computeConfidenceGivenFeature(scheme);
                double conf2 = computeConfidenceGivenSelection(scheme);
                if (support > supp_threshold && lift> lift_threshold && conf>confidence_threshold && conf2 > confidence_threshold) {
                    String[] param = new String[2];
                    param[0] = Params.orbit_list[i];
                    param[1] = Params.instrument_list[j];
                    String featureName = "inOrbit[" + param[0] + ", " + param[1] + "]";
                    drivingFeatures.add(new DrivingFeature(featureName,"inOrbit", param, lift, support, conf, conf2));
                }
            }
        }
        scheme.setName("notInOrbit");
        for (int i = 0; i < norb; ++i) {
            for (int j = 0; j < ninstr; ++j) {
                scheme.setInstrument (j);
                scheme.setOrbit(i);
                double support = computeSupport (scheme);
                double lift = computeLift (scheme);
                double conf = computeConfidenceGivenFeature(scheme);
                double conf2 = computeConfidenceGivenSelection(scheme);
                if (support > supp_threshold && lift> lift_threshold && conf > confidence_threshold && conf2 > confidence_threshold) {
                    String[] param = new String[2];
                    param[0] = Params.orbit_list[i];
                    param[1] = Params.instrument_list[j];
                    String featureName = "notInOrbit[" + param[0] + ", " + param[1] + "]";
                    drivingFeatures.add(new DrivingFeature(featureName,"notInOrbit", param, lift, support, conf, conf2));
                } 
            }
        }
        scheme.setName("together2");
        for (int i = 0; i < ninstr; ++i) {
            for (int j = 0; j < i; ++j) {
                scheme.setInstrument(i);
                scheme.setInstrument2(j);
                double support = computeSupport(scheme);
                double lift = computeLift(scheme);
                double conf = computeConfidenceGivenFeature(scheme);
                double conf2 = computeConfidenceGivenSelection(scheme);
                if (support > supp_threshold && lift>lift_threshold && conf> confidence_threshold && conf2 > confidence_threshold) {
                    String[] param = new String[2];
                    param[0] = Params.instrument_list[i];
                    param[1] = Params.instrument_list[j];
                    String featureName = "together2[" + param[0] + ", " + param[1] + "]";
                    drivingFeatures.add(new DrivingFeature(featureName,"together2", param, lift, support, conf, conf2));
                }
            }
        }            
        scheme.setName("togetherInOrbit2");
        for (int i = 0; i < norb; ++i) {
            for (int j = 0; j < ninstr; ++j) {
                for (int k = 0; k < j; ++k) {
                    scheme.setInstrument(j);
                    scheme.setInstrument2(k);
                    scheme.setOrbit(i);
                    double support = computeSupport(scheme);
                    double lift = computeLift(scheme);
                    double conf = computeConfidenceGivenFeature(scheme);
                    double conf2 = computeConfidenceGivenSelection(scheme);
                    if (support > supp_threshold && lift> lift_threshold && conf > confidence_threshold && conf2 > confidence_threshold) {
                        String[] param = new String[3];
                        param[0] = Params.orbit_list[i];
                        param[1] = Params.instrument_list[j];
                        param[2] = Params.instrument_list[k];
                        String featureName = "togetherInOrbit2[" + param[0] + ", " + param[1] + 
                                ", " + param[2] + "]"; 
                        drivingFeatures.add(new DrivingFeature(featureName,"togetherInOrbit2", param, lift, support, conf, conf2));
                    }
                }
            }
        }
        scheme.setName("separate2");
        for (int i = 0; i < ninstr; ++i) {
            for (int j = 0; j < i; ++j) {
                scheme.setInstrument(i);
                scheme.setInstrument2(j);
                double support = computeSupport(scheme);
                double lift = computeLift(scheme);
                double conf = computeConfidenceGivenFeature(scheme);
                double conf2 = computeConfidenceGivenSelection(scheme);
                    if (support > supp_threshold && lift>lift_threshold && conf > confidence_threshold && conf2 > confidence_threshold) {
                        String[] param = new String[2];
                        param[0] = Params.instrument_list[i];
                        param[1] = Params.instrument_list[j];
                        String featureName = "separate2[" + param[0] + ", " + param[1] + "]";
                        drivingFeatures.add(new DrivingFeature(featureName,"separate2", param, lift, support, conf, conf2));
                    }
            }            
        }
        scheme.setName("together3");
        for (int i = 0; i < ninstr; ++i) {
            for (int j = 0; j < i; ++j) {
                for (int k = 0; k < j; ++k) {
                    scheme.setInstrument(i);
                    scheme.setInstrument2(j);
                    scheme.setInstrument3(k);
                    double support = computeSupport(scheme);
                    double lift = computeLift(scheme);
                    double conf = computeConfidenceGivenFeature(scheme);
                    double conf2 = computeConfidenceGivenSelection(scheme);
                    if (support > supp_threshold && lift > lift_threshold && conf > confidence_threshold && conf2 > confidence_threshold) {
                        String[] param = new String[3];
                        param[0] = Params.instrument_list[i];
                        param[1] = Params.instrument_list[j];
                        param[2] = Params.instrument_list[k];
                        String featureName = "together3[" + param[0] + ", " + 
                                            param[1] + ", " + param[2] + "]";
                        drivingFeatures.add(new DrivingFeature(featureName,"together3", param, lift, support, conf, conf2));
                    }
                }
            }            
        }
        scheme.setName("togetherInOrbit3");
        for (int i = 0; i < norb; ++i) {
            for (int j = 0; j < ninstr; ++j) {
                for (int k = 0; k < j; ++k) {
                    for (int l = 0; l < k; ++l) {
                        scheme.setName("togetherInOrbit3");
                        scheme.setInstrument(j);
                        scheme.setInstrument2(k);
                        scheme.setInstrument3(l);
                        scheme.setOrbit(i);
                        double support = computeSupport(scheme);
                        double lift = computeLift(scheme);
                        double conf = computeConfidenceGivenFeature(scheme);
                        double conf2 = computeConfidenceGivenSelection(scheme);
                        if (support > supp_threshold && lift > lift_threshold && conf > confidence_threshold && conf2 > confidence_threshold) {
                            String[] param = new String[4];
                            param[0] = Params.orbit_list[i];
                            param[1] = Params.instrument_list[j];
                            param[2] = Params.instrument_list[k];
                            param[3] = Params.instrument_list[l];
                            String featureName = "togetherInOrbit3[" + param[0] + ", " + 
                                                param[1] + ", " + param[2] + "," + param[3] + "]";
                            drivingFeatures.add(new DrivingFeature(featureName,"togetherInOrbit3", param, lift, support, conf, conf2));
                        }
                    }
                }
            }
        }
        scheme.setName("separate3");
        for (int i = 0; i < ninstr; ++i) {
            for (int j = 0; j < i; ++j) {
                for (int k = 0; k < j; ++k) {
                    scheme.setInstrument(i);
                    scheme.setInstrument2(j);
                    scheme.setInstrument3(k);
                    double support = computeSupport(scheme);
                    double lift = computeLift(scheme);
                    double conf = computeConfidenceGivenFeature(scheme);
                    double conf2 = computeConfidenceGivenSelection(scheme);
                    if (support > supp_threshold && lift>lift_threshold && conf > confidence_threshold && conf2 > confidence_threshold) {
                        String[] param = new String[3];
                        param[0] = Params.instrument_list[i];
                        param[1] = Params.instrument_list[j];
                        param[2] = Params.instrument_list[k];
                        String featureName = "separate3[" + param[0] + ", " + 
                                            param[1] + ", " + param[2] + "]";
                        drivingFeatures.add(new DrivingFeature(featureName,"separate3", param, lift, support, conf, conf2));
                    }
                }
            }
        }
        scheme.setName("emptyOrbit");
        for (int i = 0; i < norb; ++i) {
            scheme.setOrbit(i);
            double support = computeSupport(scheme);
            double lift = computeLift(scheme);
            double conf = computeConfidenceGivenFeature(scheme);
            double conf2 = computeConfidenceGivenSelection(scheme);
            if (support > supp_threshold && lift > lift_threshold && conf > confidence_threshold && conf2 > confidence_threshold) {
                String[] param = new String[1];
                param[0] = Params.orbit_list[i];
                String featureName = "emptyOrbit[" + param[0] + "]";
                drivingFeatures.add(new DrivingFeature(featureName,"emptyOrbit", param, lift, support, conf, conf2));
            }
        }
        scheme.setName("numOrbits");
        for (int i = 1; i < norb+1; i++) {
            scheme.setNumOrbits(i);
            double support = computeSupport(scheme);
            double lift = computeLift(scheme);
            double conf = computeConfidenceGivenFeature(scheme);
            double conf2 = computeConfidenceGivenSelection(scheme);
            if (support > supp_threshold && lift>lift_threshold && conf > confidence_threshold && conf2 > confidence_threshold) {
                String[] param = new String[1];
                param[0] = "" + i;
                String featureName = "numOrbits[" + param[0] + "]";
                drivingFeatures.add(new DrivingFeature(featureName,"numOrbits", param, lift, support, conf, conf2));
            }
        }
        for (DrivingFeature userDef1:userDef){
            
            scheme.setName(userDef1.getType());
            double support = computeSupport(scheme);
            double lift = computeLift(scheme);
            double conf = computeConfidenceGivenFeature(scheme);
            double conf2 = computeConfidenceGivenSelection(scheme);
            if (support > supp_threshold && lift>lift_threshold && conf > confidence_threshold && conf2 > confidence_threshold) {
                drivingFeatures.add(new DrivingFeature(userDef1.getName(),userDef1.getType(),lift, support, conf, conf2));
            }
        }
        
        getDataFeatureMat();
        
//        System.out.println("----------mRMR-----------");
//        ArrayList<String> mRMR = minRedundancyMaxRelevance(40);
//        for(String mrmr:mRMR){
//            System.out.println(drivingFeatures.get(Integer.parseInt(mrmr)).getName());
//        }

        return drivingFeatures;
    }
    
    
    public int[][] booleanToInt(boolean[][] b) {
        int[][] intVector = new int[b.length][b[0].length]; 
        for(int i = 0; i < b.length; i++){
            for(int j = 0; j < b[0].length; ++j) intVector[i][j] = b[i][j] ? 1 : 0;
        }
        return intVector;
    }
    
    public static DrivingFeaturesGenerator getInstance()
    {
        if( instance == null ) 
        {
            instance = new DrivingFeaturesGenerator();
        }
        return instance;
    }

    public int[][] getDataFeatureMat(){
        
        int numData = randomData.size();
        int numFeature = drivingFeatures.size() + 1; // add class label as a last feature
        int[][] dataMat = new int[numData][numFeature];
        
        for(int i=0;i<numData;i++){
            int[][] d = randomData.get(i);
            Scheme s = new Scheme();

//            presetFilter(String filterName, int[][] data, ArrayList<String> params
            for(int j=0;j<numFeature-1;j++){
                DrivingFeature f = drivingFeatures.get(j);
                String name = f.getName();
                String type = f.getType();
                
                if(f.isPreset()){
                    String[] param_ = f.getParam();
                    ArrayList<String> param = new ArrayList<>();
                    param.addAll(Arrays.asList(param_));
                    if(s.presetFilter(type, d, param)){
                        dataMat[i][j]=1;
                    } else{
                        dataMat[i][j]=0;
                    }
                } else{
                    if(s.userDefFilter_eval(type, d)){
                        dataMat[i][j]=1;
                    } else{
                        dataMat[i][j]=0;
                    }
                }
            }
            
            boolean classLabel = false;
            for (int[][] compData : focusData) {
                boolean match = true;
                for(int k=0;k<d.length;k++){
                    for(int l=0;l<d[0].length;l++){
                        if(d[k][l]!=compData[k][l]){
                            match = false;
                            break;
                        }
                    }
                    if(match==false) break;
                }
                if(match==true){
                    classLabel = true;
                    break;
                }
            }
            if(classLabel==true){
                dataMat[i][numFeature-1]=1;
            } else{
                dataMat[i][numFeature-1]=0;
            }
        }
        dataFeatureMat = dataMat;
        return dataMat;
    }
    public ArrayList<String> minRedundancyMaxRelevance(int numSelectedFeatures){
        
        int[][] m = dataFeatureMat;
        int numFeatures = m[0].length;
        int numData = m.length;
        ArrayList<String> selected = new ArrayList<>();
        
        while(selected.size() < numSelectedFeatures){
            double phi = -10000;
            int save=0;
            for(int i=0;i<numFeatures-1;i++){
                if(selected.contains(""+i)){
                    continue;
                }

                double D = getMutualInformation(i,numFeatures-1);
                double R = 0;

                for (String selected1 : selected) {
                    R = R + getMutualInformation(i, Integer.parseInt(selected1));
                }
                if(!selected.isEmpty()){
                   R = (double) R/selected.size();
                }
                
//                System.out.println(D-R);
                
                if(D-R > phi){
                    phi = D-R;
                    save = i;
                }
            }
//            System.out.println(save);
            selected.add(""+save);
        }
        return selected;
    }  
    public double getMutualInformation(int feature1, int feature2){
        
        int[][] m = dataFeatureMat;
        int numFeatures = m[0].length;
        int numData = m.length;
        double I;
        
        int x1=0,x2=0;
        int x1x2=0,nx1x2=0,x1nx2=0,nx1nx2=0;      

        for(int k=0;k<numData;k++){
            if(m[k][feature1]==1){ // x1==1
                x1++;
                if(m[k][feature2]==1){ // x2==1
                    x2++;
                    x1x2++;
                } else{ // x2!=1
                    x1nx2++;
                }
            } else{ // x1!=1
                if(m[k][feature2]==1){ // x2==1 
                    x2++;
                    nx1x2++;
                }else{ // x2!=1
                    nx1nx2++;
                }
            }
        }
        double p_x1 =(double) x1/numData;
        double p_nx1 = (double) 1-p_x1;
        double p_x2 = (double) x2/numData;
        double p_nx2 = (double) 1-p_x2;
        double p_x1x2 = (double) x1x2/numData;
        double p_nx1x2 = (double) nx1x2/numData;
        double p_x1nx2 = (double) x1nx2/numData;
        double p_nx1nx2 = (double) nx1nx2/numData;
        
        if(p_x1==0){p_x1 = 0.0001;}
        if(p_nx1==0){p_nx1=0.0001;}
        if(p_x2==0){p_x2=0.0001;}
        if(p_nx2==0){p_nx2=0.0001;}
        if(p_x1x2==0){p_x1x2=0.0001;}
        if(p_nx1x2==0){p_nx1x2=0.0001;}
        if(p_x1nx2==0){p_x1nx2=0.0001;}
        if(p_nx1nx2==0){p_nx1nx2=0.0001;}
        
        double i1 = p_x1x2*Math.log(p_x1x2/(p_x1*p_x2));
        double i2 = p_x1nx2*Math.log(p_x1nx2/(p_x1*p_nx2));
        double i3 = p_nx1x2*Math.log(p_nx1x2/(p_nx1*p_x2));
        double i4 = p_nx1nx2*Math.log(p_nx1nx2/(p_nx1*p_nx2));

        I = i1 + i2 + i3 + i4;
        return I;
    }
    
    
    

    
    public void addUserDefFilter(String name, String expression){
        this.userDef.add(new DrivingFeature(name,expression));
    }
    
    

}
