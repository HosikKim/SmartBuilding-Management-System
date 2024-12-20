package edu.sm.util;

import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;

public class WeatherUtil {

    public static Object getWeather2(String lat, String lon, String key) throws IOException, ParseException {

        String sendUrl ="https://api.openweathermap.org/data/2.5/forecast";

        StringBuilder urlBuilder = new StringBuilder(sendUrl); /*URL*/
        urlBuilder.append("?" +URLEncoder.encode("lat","UTF-8") + "="+lat);
        urlBuilder.append("&" + URLEncoder.encode("lon","UTF-8") + "="+lon);
        urlBuilder.append("&" + URLEncoder.encode("units","UTF-8") + "=" + "metric");
        urlBuilder.append("&" + URLEncoder.encode("lang","UTF-8") + "=" + "kr");
        urlBuilder.append("&" + URLEncoder.encode("appid","UTF-8") + "=" + key);

        URL url = new URL(urlBuilder.toString());
        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
        conn.setRequestMethod("GET");
        conn.setRequestProperty("Content-type", "application/json");
        //System.out.println("Response code: " + conn.getResponseCode());
        BufferedReader rd;
        if(conn.getResponseCode() >= 200 && conn.getResponseCode() <= 300) {
            rd = new BufferedReader(new InputStreamReader(conn.getInputStream()));
        } else {
            rd = new BufferedReader(new InputStreamReader(conn.getErrorStream()));
        }
        StringBuilder sb = new StringBuilder();
        String line;
        while ((line = rd.readLine()) != null) {
            sb.append(line);
        }
        rd.close();
        conn.disconnect();
        //System.out.println(sb.toString());
        JSONParser jsonParser = new JSONParser();
        JSONObject jsonObject = (JSONObject) jsonParser.parse(sb.toString());
        return jsonObject;
    }
}
