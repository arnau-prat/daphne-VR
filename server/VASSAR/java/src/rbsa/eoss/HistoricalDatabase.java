/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package rbsa.eoss;

import java.sql.*;
import java.util.*;

/**
 *
 * @author Arnau
 */

// To make the postgresql connection work, modify the file pga_hba.config:
//
// local    all     all             trust
// host     all     127.0.0.1/32    trust

public class HistoricalDatabase {

    private Connection conn = null;
    // Ceos database credentials
    private String url = "jdbc:postgresql:ceos";
    private String username = "ubuntu";
    private String password = "";

    public HistoricalDatabase() {
        // Connect to the database
        try {
            Class.forName("org.postgresql.Driver");
            conn = DriverManager.getConnection(url, username, password);
        } catch (SQLException e) {
            System.out.print(" Unable set the connection!");
        } catch (ClassNotFoundException e) {
            System.out.print(" Unable to load the driver class!");
        }
    }

    public List<Integer> getMissionsInOrbit(String type, int altitude, String LST) {
        List<Integer> result = new ArrayList<Integer>();
        // Query to be performed
        String query = "SELECT id FROM missions WHERE orbit_type = '"
            +type+"' AND orbit_altitude = "+String.valueOf(altitude);
        try {
            Statement st = conn.createStatement();
            ResultSet rs = st.executeQuery(query);
            while(rs.next()) {
                result.add(rs.getInt("id"));
            }
            rs.close();
            st.close();
        } catch(Exception e) {
            e.printStackTrace();
        }
        return result;
    }

    public List<Integer> getInstrumentsInMission(int missionID) {
        List<Integer> result = new ArrayList<Integer>();
        // Query to be performed
        String query = "SELECT instrument_id FROM instruments_in_mission WHERE"
            +" mission_id = "+String.valueOf(missionID);
        try {
            Statement st = conn.createStatement();
            ResultSet rs = st.executeQuery(query);
            while(rs.next()) {
                result.add(rs.getInt("instrument_id"));
            }
            rs.close();
            st.close();
        } catch(Exception e) {
            e.printStackTrace();
        }
        return result;
    }

    public List<Integer> getInstruments(
        String type, String technology, String geometry, String waveband) {

        List<Integer> result = new ArrayList<Integer>();
        // Query to be performed
        String query ="SELECT id FROM instruments i"+
            " INNER JOIN type_of_instrument it ON i.id = it.instrument_id"+
            " INNER JOIN instrument_types t ON it.instrument_type_id = t.id"+
            " INNER JOIN geometry_of_instrument ig ON i.id = ig.instrument_id"+
            " INNER JOIN geometry_types g ON ig.instrument_geometry_id = g.id"+
            " INNER JOIN instrument_wavebands iw ON i.id = iw.instrument_id"+
            " INNER JOIN instrument_wavebands iw ON i.id = iw.instrument_id "+
            " INNER JOIN wavebands w ON iw.waveband_id = w.id"+
            " WHERE t.name = '"+type+"'";

        //    SELECT i.id FROM instruments i 
        //    INNER JOIN type_of_instrument it ON i.id = it.instrument_id
        //    INNER JOIN instrument_types t ON it.instrument_type_id = t.id
        //    INNER JOIN geometry_of_instrument ig ON i.id = ig.instrument_id
        //    INNER JOIN geometry_types g ON ig.instrument_geometry_id = g.id
        //    INNER JOIN instrument_wavebands iw ON i.id = iw.instrument_id
        //    INNER JOIN wavebands w ON iw.waveband_id = w.id
        //    WHERE t.name = 'Space environment' AND
        //    i.technology = 'Space environment monitor' AND
        //    g.name = 'TBD' AND
        //    w.name = ''

        try {
            Statement st = conn.createStatement();
            ResultSet rs = st.executeQuery(query);
            while(rs.next()) {
                result.add(rs.getInt("id"));
            }
            rs.close();
            st.close();
        } catch(Exception e) {
            e.printStackTrace();
        }
        return result;
    }

    public String getInstrumentType(int instrumentID) {
        String result = "";
        try {
            Statement st = conn.createStatement();
            ResultSet rs = st.executeQuery("SELECT instrument_type_id FROM type_of_instrument WHERE"
                +" instrument_id = "+instrumentID);
            int rr = 0;
            if(rs.next()) {
                rr = rs.getInt("instrument_type_id");
            }
            rs = st.executeQuery("SELECT name FROM instrument_types WHERE id = "+rr);
            if(rs.next()) {
                result = rs.getString("name");
            }
            rs.close();
            st.close();
        } catch(Exception e) {
            e.printStackTrace();
        }
        return result;
    }

    public List<Integer> getInstrumentsOfType(String type, String technology, String waveband) {
        List<Integer> result = new ArrayList<Integer>();
        return result;
    }
}
