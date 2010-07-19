package org.example.browserview;

import java.util.ArrayList;

import android.app.Activity;
import android.os.Bundle;
import android.view.KeyEvent;
import android.view.View;
import android.view.View.OnClickListener;
import android.view.View.OnKeyListener;

import android.webkit.WebView;
// ...

import android.widget.Button;
import android.widget.EditText;

/**
 * 
 * @author Murtaza Jafferji
 * BrowserView
 * When a user clicks "Go", he is taken to the definitious
 * page for the word he typed in the box. If the word isn't
 * defined, he will be asked if he wants to define it.
 */
public class BrowserView extends Activity {
   
   private EditText urlText;
   private Button goButton;
   private WebView webView;
   

   /**
    * This is called when the activity is started,
    * so we override the default onCreate.
    * @param savedInstanceState
    */
   @Override
   public void onCreate(Bundle savedInstanceState) {
      // ...
      
      super.onCreate(savedInstanceState);
      setContentView(R.layout.main);

      // Get a handle to all user interface elements
      urlText = (EditText) findViewById(R.id.url_field);
      goButton = (Button) findViewById(R.id.go_button);
      
      webView = (WebView) findViewById(R.id.web_view);
      

      // Setup event handlers
      goButton.setOnClickListener(
    	 new OnClickListener() 
    	 {
    	/**
    	 * onClick
    	 * @param view a view
    	 * The user just has to type in a word
    	 * and he will get the definitious 
    	 * page for that word. 
    	 */
         public void onClick(View view)
         {
        	//if there is already a valid address, don't do this
        	if(urlText.getText().toString().contains("http://") == false)
        	{
            	String word = urlText.getText().toString();
            	urlText.setText("http://definitious.com/finds?word=" + word);
        	}
            openBrowser();
            
         }
      });
      urlText.setOnKeyListener(new OnKeyListener() {
         public boolean onKey(View view, int keyCode, KeyEvent event) {
            if (keyCode == KeyEvent.KEYCODE_ENTER) {
               openBrowser();
               return true;
            }
            return false;
         }
      });
      
   }
   

   
   /** Open a browser on the URL specified in the text box */
   private void openBrowser() {
      webView.getSettings().setJavaScriptEnabled(true);
      webView.loadUrl(urlText.getText().toString());
   }
   
   
}
