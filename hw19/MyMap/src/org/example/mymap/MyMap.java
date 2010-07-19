
package org.example.mymap;

import java.util.List;

import android.graphics.Point;
import android.os.Bundle;
import android.view.MotionEvent;
import android.widget.Toast;

import com.google.android.maps.GeoPoint;
import com.google.android.maps.MapActivity;
import com.google.android.maps.MapController;
import com.google.android.maps.MapView;
import com.google.android.maps.MyLocationOverlay;
import com.google.android.maps.Overlay;

/**
 * 
 * @author Murtaza Jafferji
 * MyMap extends MapActivity
 * Creates a map activity.
 * Displays how many degrees off in each direction
 * the place that the user touches is from Dallas, TX.
 */
public class MyMap extends MapActivity {
   private MapView map;
   private MapController controller;

   /**
    * 
    * @author Murtaza Jafferji
    * MapOverLay extends com.google.android.maps.Overlay
    * Displays how many degrees off in each direction
    * the place that the user touches is from Dallas, TX.
    * 
    */
   class MapOverlay extends com.google.android.maps.Overlay
   {
	   
       @Override
       public boolean onTouchEvent(MotionEvent event, MapView mapView) 
       {   
           if (event.getAction() == 1) 
           {                
               GeoPoint p = mapView.getProjection().fromPixels(
                   (int) event.getX(),
                   (int) event.getY());
               //toast notification
                   Toast.makeText(getBaseContext(), 
                	  //the toast notification displays how many degrees away from Dallas, TX
                       ((p.getLatitudeE6() / 1E6) - 32.73) + "," + 
                       ((p.getLongitudeE6() /1E6) - 96.97) , 
                       Toast.LENGTH_SHORT).show();
           }                            
           return false;
       }        
   }
   @Override
   /**
    * onCreate
    * @param savedInstanceState type Bundle
    * This is executed when someone starts 
    * the activity. 
    */
   public void onCreate(Bundle savedInstanceState) {
      super.onCreate(savedInstanceState);
      setContentView(R.layout.main);
      initMapView();
      initMyLocation();
      MapOverlay mapOverlay = new MapOverlay();
      List<Overlay> listOfOverlays = map.getOverlays();
      listOfOverlays.clear();
      listOfOverlays.add(mapOverlay); 
   }
   

   
   /** Find and initialize the map view. */
   private void initMapView() {
      map = (MapView) findViewById(R.id.map);
      controller = map.getController();
      map.setSatellite(true);
      map.setBuiltInZoomControls(true);
   }
   

   
   /** Start tracking the position on the map. */
   private void initMyLocation() {
      final MyLocationOverlay overlay = new MyLocationOverlay(this, map);
      overlay.enableMyLocation();
      overlay.runOnFirstFix(new Runnable() {
         public void run() {
            controller.setZoom(8);
            controller.animateTo(overlay.getMyLocation());
         }
      });
      map.getOverlays().add(overlay);
   }
   

   
   @Override
   protected boolean isRouteDisplayed() {
      return false;
   }
   
}
