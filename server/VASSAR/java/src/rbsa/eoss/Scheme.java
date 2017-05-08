/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package rbsa.eoss;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.Comparator;
import rbsa.eoss.local.Params;

/**
 *
 * @author Clara
 */
public class Scheme implements Comparator{
    
    private String name;//present, absent, inOrbit, notInOrbit, together2, togetherInOrbit2, 
    //separete2, together3, togetherInOrbit3, separete3, emptyOrbit, numOrbits
    private int instrument;
    private int orbit;
    private int instrument2, instrument3;
    private int numOrbits;
    private final int ninstr;
    private final int norb;
//    private ArrayList<String> presetFeatureNames;
//    int tmpcnt;
    
    public Scheme(){
//        presetFeatureNames = new ArrayList<>();
//        presetFeatureNames.add("present");
//        presetFeatureNames.add("absent");
//        presetFeatureNames.add("inOrbit");
//        presetFeatureNames.add("notInOrbit");
//        presetFeatureNames.add("together2");
//        presetFeatureNames.add("togetherInOrbit2");
//        presetFeatureNames.add("separate2");
//        presetFeatureNames.add("together3");
//        presetFeatureNames.add("togetherInOrbit3");
//        presetFeatureNames.add("separate3");
//        presetFeatureNames.add("emptyOrbit");
//        presetFeatureNames.add("numOrbits");
//        presetFeatureNames.add("subsetOfInstruments");
        norb = Params.orbit_list.length;
        ninstr = Params.instrument_list.length;
    }
    
     @Override
    public int compare(Object o1, Object o2) {
        int[][] data = (int[][]) o1;
        if (name.equals("present")) {
            for (int i = 0; i < data.length; ++i) {
                if (data[i][instrument] == 1){
                    return 1;
                }
            }
            return 0;            
        }
        else if (name.equals("absent")) {
            for (int i = 0; i < data.length; ++i) {
                if (data[i][instrument] == 1) return 0;
            }
            return 1;  
        }
        else if (name.equals("inOrbit")) {
            if (data[orbit][instrument] == 1) return 1;
            return 0;            
        }
        else if (name.equals("notInOrbit")) {
            if (data[orbit][instrument] == 1) return 0;
            return 1;            
        }
        else if (name.equals("together2")) {
            int together = 0;
            for (int i = 0; i < data.length && together == 0; ++i) {
                if (data[i][instrument] == data[i][instrument2] && data[i][instrument] == 1) together = 1;
            }
            return together;            
        }
        else if (name.equals("togetherInOrbit2")) {
            int together = 0;
            if (data[orbit][instrument] == 1 && data[orbit][instrument2] == 1) together = 1;
            return together;            
        }
        else if (name.equals("separate2")) {
            int separate = 1;
            for (int i = 0; i < data.length && separate == 1; ++i) {
                if (data[i][instrument] == 1 && data[i][instrument2] == 1) separate = 0;
            }            
            return separate;            
        }
        else if (name.equals("together3")) {
            int together = 0;
            for (int i = 0; i < data.length && together == 0; ++i) {
                if (1 == data[i][instrument2] && data[i][instrument] == 1 && data[i][instrument3] == 1) together = 1;
            }
            return together;            
        }
        else if (name.equals("togetherInOrbit3")) {
            int together = 0;
            if (data[orbit][instrument] == 1 && data[orbit][instrument2] == 1 && data[orbit][instrument3] == 1) together = 1;
            return together;            
        }
        else if (name.equals("separate3")) {
            int separate = 1;
            for (int i = 0; i < data.length && separate == 1; ++i) {
                if ((data[i][instrument] == 1 && data[i][instrument2] == 1) || 
                        (data[i][instrument] == 1 && data[i][instrument3] == 1) ||
                         (data[i][instrument2] == 1 && data[i][instrument3] == 1)) separate = 0;
            }            
            return separate;            
        }
        else if (name.equals("emptyOrbit")) {
            for (int i = 0; i < data[0].length; ++i) {
                if (data[orbit][i] == 1) return 0;
            }
            return 1;
        }
        else if (name.equals("numOrbits")) {
            int coincident = 0;
            int count = 0;
            for (int i = 0; i < data.length; ++i) {
               boolean empty= true;
               for (int j=0; j< data[i].length;j++){
                   if(data[i][j]==1){
                       empty= false;
                   }
               }
               if(empty==true) count++;
            }
            if (numOrbits == data.length - count) return 1;
            return 0;
        }
        else {
            if(userDefFilter_eval(name,data)) return 1;
            return 0;
        }
                
    }


    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public int getInstrument() {
        return instrument;
    }

    public void setInstrument(int instrument) {
        this.instrument = instrument;
    }

    public int getOrbit() {
        return orbit;
    }

    public void setOrbit(int orbit) {
        this.orbit = orbit;
    }

    public int getInstrument2() {
        return instrument2;
    }

    public void setInstrument2(int instrument2) {
        this.instrument2 = instrument2;
    }

    public int getInstrument3() {
        return instrument3;
    }

    public void setInstrument3(int instrument3) {
        this.instrument3 = instrument3;
    }

    public int getNumOrbits() {
        return numOrbits;
    }

    public void setNumOrbits(int numOrbits) {
        this.numOrbits = numOrbits;
    }
    

    public boolean userDefFilter_eval(String filterExpression,int[][] data){
        
        String e = filterExpression;
        while(e.contains("{")){
            int level=0;
            int maxLevel=0;

            for(int i=0;i<e.length();i++){
                String thisChar = e.substring(i,i+1);
                if(thisChar.equalsIgnoreCase("{")){
                    level++;
                    if(level > maxLevel){
                        maxLevel = level;
                    }
                } else if(thisChar.equalsIgnoreCase("}")){
                    level--;
                }
            }
            level=0;
            int maxLevelLoc = 0;
            for(int i=0;i<e.length();i++){
                String thisChar = e.substring(i,i+1);
                if(thisChar.equalsIgnoreCase("{")){
                    level++;
                    if(level==maxLevel){
                        maxLevelLoc = i;
                        break;
                    }
                } else if(thisChar.equalsIgnoreCase("}")){
                    level--;
                }
            }
            
            String innermostExpression = e.substring(maxLevelLoc+1);
            innermostExpression = innermostExpression.substring(0, innermostExpression.indexOf("}"));
            boolean bool = userDefFilter_evalWithoutParen(innermostExpression,data);
            String e1,e2;
            if(maxLevelLoc==0){e1 = "";}
            else {e1 = e.substring(0,maxLevelLoc);}
            if(maxLevelLoc + 1 + innermostExpression.length() + 1 == e.length()){e2 = "";}
            else {e2 = e.substring(maxLevelLoc + innermostExpression.length() + 2);}
//            if(tmpcnt==0){System.out.println(e);}
            if(bool){
                e = e1 + "true()" + e2;
            } else{
                e = e1 + "false()" + e2;
            }
        }
        return userDefFilter_evalWithoutParen(e,data); 
    }
    
    public boolean userDefFilter_evalWithoutParen(String filterExpression,int[][] data){
        
        String e = filterExpression;
        String logic = "and";
        boolean output = true;
        
        while(true){
//            if(tmpcnt==0){System.out.println(e);}
            int andLoc = e.indexOf("&&");
            int orLoc = e.indexOf("||");
            
            if(andLoc==-1 && orLoc==-1){ //single preset feature
                output = userDefFilter_evalSingle(e,output,logic,data);
                break;
            } else{
                int firstLogicLoc;
                String nextLogic;
                if(andLoc==-1){
                    firstLogicLoc = orLoc;
                    nextLogic = "or";
                } else if(orLoc==-1){
                    firstLogicLoc = andLoc;
                    nextLogic="and";
                } else if(andLoc < orLoc){
                    firstLogicLoc = andLoc;
                    nextLogic = "and";
                } else{
                    firstLogicLoc = orLoc;
                    nextLogic = "or";
                }
                
                output = userDefFilter_evalSingle(e.substring(0,firstLogicLoc),output,logic,data);
                e = e.substring(firstLogicLoc+2);
                logic = nextLogic;
            }
        }
//        tmpcnt++;
        return output;
    }
            
    public boolean userDefFilter_evalSingle(String filterExpression,boolean prev,String logic,int[][] data){

        String e = filterExpression;
        int paren1 = e.indexOf("(");
        int paren2 = e.indexOf(")");
        if(paren1==-1){System.out.println(e);}
        String filterName = e.substring(0,paren1);
        String params = e.substring(paren1+1,paren2);
        ArrayList<String> param = new ArrayList<>();
        boolean output=true;
        
        if(!params.contains(";")){
            param.add(params);
        } else{
            while(params.contains(";")){
                int semicolon = params.indexOf(";");
                param.add(params.substring(0,semicolon));
                params = params.substring(semicolon+1);
            }
            param.add(params);
        }
        
        if(filterName.equalsIgnoreCase("true")){
            output= true;
        } else if(filterName.equalsIgnoreCase("false")){
            output = false;
        } else {
            output = presetFilter(filterName,data,param);
        }
        
        if(prev==output){
            return prev;
        } else{
            return logic.equalsIgnoreCase("or");
        }
    }
    
    public String relabelback(String input){

        String[] newOrbitList = {"1000","2000","3000","4000","5000"};
        String[] newInstrList = {"A","B","C","D","E","F","G","H","I","J","K","L"};

        if(input.contains("000")){
           int nth=0;
           for(int i=0;i<newOrbitList.length;i++){
               if(newOrbitList[i].equalsIgnoreCase(input)){
                   nth=i;
                   break;
               }
           }
           return Params.orbit_list[nth];
        }else if(input.length()==1){
           int nth=0;
           for(int i=0;i<newInstrList.length;i++){
               if(newInstrList[i].equalsIgnoreCase(input)){
                   nth=i;
                   break;
               }
           }
           return Params.instrument_list[nth];
        } else{
            return input;
        }
    }
    
    
    public boolean presetFilter(String filterName, int[][] data, ArrayList<String> params){

//        if(tmpcnt==0){System.out.println(params.get(0));}
//        Scheme s = new Scheme();
        Scheme s = this;
        String[] instr_list = Params.instrument_list;
        String[] orbit_list = Params.orbit_list;
//        if(tmpcnt==0){System.out.println(instr_list.length);}
//        if(tmpcnt==0){System.out.println(ninstr);}        
        
        if(filterName.equalsIgnoreCase("present")){
            int inst=0;
            for(int i=0;i<ninstr;i++){
                if(instr_list[i].equalsIgnoreCase(relabelback(params.get(0)))){
                    inst = i;
                    break;
                }
            }
            s.setName("present");
            s.setInstrument(inst);
        } else if(filterName.equalsIgnoreCase("absent")){
            int inst=0;
            for(int i=0;i<ninstr;i++){
                if(instr_list[i].equalsIgnoreCase(relabelback(params.get(0)))){
                    inst = i;
                    break;
                }
            }
            s.setName("absent");
            s.setInstrument(inst);
        } else if(filterName.equalsIgnoreCase("inOrbit")){
            int orb=0;
            int inst=0;
            for(int i=0;i<norb;i++){
                if(orbit_list[i].equalsIgnoreCase(relabelback(params.get(0)))){
                    orb = i;
                    break;
                }
            }
            for(int i=0;i<ninstr;i++){
                if(instr_list[i].equalsIgnoreCase(relabelback(params.get(1)))){
                    inst = i;
                    break;
                }
            }
            s.setName("inOrbit");
            s.setOrbit(orb);
            s.setInstrument(inst);
        } else if(filterName.equalsIgnoreCase("notInOrbit")){
            int orb=0;
            int inst=0;
            for(int i=0;i<norb;i++){
                if(orbit_list[i].equalsIgnoreCase(relabelback(params.get(0)))){
                    orb = i;
                    break;
                }
            }
            for(int i=0;i<ninstr;i++){
                if(instr_list[i].equalsIgnoreCase(relabelback(params.get(1)))){
                    inst = i;
                    break;
                }
            }
            s.setName("notInOrbit");
            s.setOrbit(orb);
            s.setInstrument(inst);
        } else if(filterName.equalsIgnoreCase("together") || filterName.equalsIgnoreCase("together2") || filterName.equalsIgnoreCase("together3")){
            
            ArrayList<String> instruments = new ArrayList<>();
            for(String param:params){
                String[] inst_split = param.split(",");
                instruments.addAll(Arrays.asList(inst_split));
            }
            
            int inst1 = -1;
            int inst2 = -1;
            int inst3 = -1;
            
            for(int i=0;i<ninstr;i++){
                if(instr_list[i].equalsIgnoreCase(relabelback(instruments.get(0)))){
                    inst1 = i;
                    continue;
                }
                if(instr_list[i].equalsIgnoreCase(relabelback(instruments.get(1)))){
                    inst2 = i;
                    continue;
                }
                if(instruments.size() > 2){
                    if(instr_list[i].equalsIgnoreCase(relabelback(instruments.get(2)))){
                        inst3 = i;
                    }
                }
            }
            
            if(instruments.size()==2){
                s.setName("together2");
            } else {
                s.setName("together3");
                s.setInstrument3(inst3);
            }
            s.setInstrument(inst1);
            s.setInstrument2(inst2);
            
        } else if(filterName.equalsIgnoreCase("togetherInOrbit") || filterName.equalsIgnoreCase("togetherOrbit2") || filterName.equalsIgnoreCase("togetherOrbit3")){
            
            String thisOrbit = params.get(0);
            ArrayList<String> instruments = new ArrayList<>();
            boolean first = true;
            for(String param:params){
                if(first==true) {
                    first=false;
                    continue;
                }
                String[] inst_split = param.split(",");
                instruments.addAll(Arrays.asList(inst_split));
            }
            
            int orb = -1;
            int inst1 = -1;
            int inst2 = -1;
            int inst3 = -1;
            
            for(int i=0;i<norb;i++){
                if(orbit_list[i].equalsIgnoreCase(relabelback(thisOrbit))){
                    orb = i;
                    break;
                }
            }
            for(int i=0;i<ninstr;i++){
                if(instr_list[i].equalsIgnoreCase(relabelback(instruments.get(0)))){
                    inst1 = i;
                    continue;
                }
                if(instr_list[i].equalsIgnoreCase(relabelback(instruments.get(1)))){
                    inst2 = i;
                    continue;
                }
                if(instruments.size() > 2){
                    if(instr_list[i].equalsIgnoreCase(relabelback(instruments.get(2)))){
                        inst3 = i;
                    }
                }
            }
            
            if(instruments.size()==2){
                s.setName("togetherInOrbit2");
            } {
                s.setName("togetherInOrbit3");
                s.setInstrument3(inst3);
            }
            s.setOrbit(orb);
            s.setInstrument(inst1);
            s.setInstrument2(inst2);
            
        } else if(filterName.equalsIgnoreCase("separate") || filterName.equalsIgnoreCase("separate2")||filterName.equalsIgnoreCase("separate3")){
            
            ArrayList<String> instruments = new ArrayList<>();
            for(String param:params){
                String[] inst_split = param.split(",");
                instruments.addAll(Arrays.asList(inst_split));
            }
            
            
            int inst1 = -1;
            int inst2 = -1;
            int inst3 = -1;
            
            for(int i=0;i<ninstr;i++){
                if(instr_list[i].equalsIgnoreCase(relabelback(instruments.get(0)))){
                    inst1 = i;
                    continue;
                }
                if(instr_list[i].equalsIgnoreCase(relabelback(instruments.get(1)))){
                    inst2 = i;
                    continue;
                }
                if(instruments.size() > 2){
                    if(instr_list[i].equalsIgnoreCase(relabelback(instruments.get(2)))){
                        inst3 = i;
                    }
                }
            }
            
            if(instruments.size()==2){
                s.setName("separate2");
            } else {
                s.setName("separate3");
                s.setInstrument3(inst3);
            }
            s.setInstrument(inst1);
            s.setInstrument2(inst2);
        } else if(filterName.equalsIgnoreCase("emptyOrbit")){
            int orb=-1;
            for(int i=0;i<norb;i++){
                if(orbit_list[i].equalsIgnoreCase(relabelback(params.get(0)))){
                    orb = i;
                    break;
                }
            }
            s.setName("emptyOrbit");
            s.setOrbit(orb);
        } else if(filterName.equalsIgnoreCase("numOrbits")){
            s.setName("numOrbits");
            s.setNumOrbits(Integer.parseInt(params.get(0)));
        } else if(filterName.equalsIgnoreCase("subsetOfInstruments")){ 
            
            int orb = -1;
            
            for(int i=0;i<norb;i++){
                if(orbit_list[i].equalsIgnoreCase(relabelback(params.get(0)))){
                    orb = i;
                    break;
                }
            }
            
            int min;int max;
            if (params.get(1).contains(",")){
                min = Integer.parseInt(params.get(1).split(",")[0]);
                max = Integer.parseInt(params.get(1).split(",")[1]);
            }else{
                min = Integer.parseInt(params.get(1));
                max = 100;
            }

            int cnt = 0;
            String[] instruments = params.get(2).split(",");
            for (String instrument1 : instruments) {
                int inst = 0;
                for (int j = 0; j<ninstr; j++) {
                    if (instr_list[j].equalsIgnoreCase(relabelback(instrument1))) {
                        inst = j;
                    }
                }
                if(data[orb][inst]==1){
                    cnt++;
                }
            }
            
            return cnt <= max && cnt >= min;
        }
        

//        if(tmpcnt==0){System.out.println("getName: " + s.getName());}
//        if(tmpcnt==0){System.out.println("getInst: " + s.getInstrument());}
        return s.compare(data, "") == 1;

    }
    
    
    
    
}