package edu.brandeis.cs.jafferji;

import android.app.Activity;
import android.os.Bundle;
import android.content.Intent;
import android.view.View;
import android.view.View.OnClickListener;
import android.view.Menu;
import android.view.MenuInflater;
import android.view.MenuItem;
/**
 * 
 * @author Murtaza Jafferji
 * This is the Favorite Things Activity.
 * Has many views which are created and displayed.
 * 
 */
public class FavoriteThings extends Activity implements OnClickListener{
	
    @Override
    /**
     * The page users see when they start the application.
     * 
     * @param savedInstanceState a Bundle
     * @return void
     */
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        //set the contentView to the main.xml file in layouts.
        setContentView(R.layout.main);
        
        //Create views to contain the main screen buttons
        //assign clickListeners to each of the buttons
        View myButton = findViewById(R.id.my_button);
        myButton.setOnClickListener(this);
        View newButton = findViewById(R.id.new_button);
        newButton.setOnClickListener(this);
        View aboutButton = findViewById(R.id.about_button);
        aboutButton.setOnClickListener(this);
        View exitButton = findViewById(R.id.exit_button);
        exitButton.setOnClickListener(this);
    }
   
    /**
     * Handles the ClickListeners assigned to the buttons. 
     * Goes into the switch on (v.getID()) and starts an activities
     * @param view A view
     * @return void
     */
    public void onClick(View view)
    {
    	//takes in an ID for a view
    	switch(view.getId())
    	{
    		//for about_button
    		case R.id.about_button:
    			//intent with the About.class and startActivity on it.
    			Intent i= new Intent(this, About.class);
    			startActivity(i);
    			break;
    		//for exit_button
    		case R.id.exit_button:
    			//exit the app
    			finish();
    			break;
    			
    		case R.id.new_button:
    			Intent intent=new Intent(this, Draw.class);
    			startActivity(intent);
    			break;
    		
    	}
    	
    }
    /**
     * onCreateOptionsMenu
     * Creates a menu when the menu button is pressed
     * @param menu A Menu
     * @return boolean true
     */
    @Override
    public boolean onCreateOptionsMenu(Menu menu) {
    	super.onCreateOptionsMenu(menu);
    	MenuInflater inflater = getMenuInflater();
    	//inflate the menu when the button is pressed
    	inflater.inflate(R.menu.menu, menu);
    	return true;
    }
    
    /**
     * onOptionsItemSelected
     * For options selected from the menu screen 
     * @param item A MenuItem
     * @return boolean, if clicked
     */
    public boolean onOptionsItemSelected(MenuItem item) {
    	switch (item.getItemId()) {
    	case R.id.settings:
    	//starts a new activity here and with the Prefs.class
    	startActivity(new Intent(this, Prefs.class));
    	return true;
    	}
    	return false;
    }	
}