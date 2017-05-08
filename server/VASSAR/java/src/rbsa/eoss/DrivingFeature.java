/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package rbsa.eoss;

import java.util.ArrayList;

/**
 *
 * @author Bang
 */
 
public class DrivingFeature{
        
        private String name; // specific names
        private String type; // inOrbit, together, separate, present, absent, etc.
        private String[] param;
        private boolean preset;
        private double lift;
        private double supp;
        private double conf;  //{feature} -> {good design}
        private double conf2; // {good design} -> {feature}
        

        public DrivingFeature(String name, String type){
            this.name = name;
            this.type = type;
            this.preset = false;
        }
        public DrivingFeature(String name, String type, double lift, double supp, double conf, double conf2){
            this.name = name;
            this.type = type;
            this.lift = lift;
            this.supp = supp;
            this.conf = conf;       
            this.conf2 = conf2;
            this.preset = false;
        }
        public DrivingFeature(String name, String type, String[] param, double lift, double supp, double conf, double conf2){
            this.name = name;
            this.type = type;
            this.param = param;
            this.lift = lift;
            this.supp = supp;
            this.conf = conf;       
            this.conf2 = conf2;
            this.preset = true;
        }
        public String getType(){return type;}
        public String getName(){return name;}
        public double getLift(){return lift;}
        public double getSupport(){return supp;}
        public double getConfidence(){return conf;}
        public double getConfidence2(){return conf2;}
        public String[] getParam(){return param;}
        public boolean isPreset(){return preset;}
        
    }
