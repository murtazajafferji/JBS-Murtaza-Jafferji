package edu.brandeis.cs.jafferji;

import android.app.Activity;
import android.os.Bundle;
import android.widget.Button;
import android.widget.EditText;
import android.view.View;
import android.view.View.OnClickListener;

public class FahrenheitToKelvin extends Activity implements OnClickListener {
Button convertButton;
EditText fahrenheitText;
EditText kelvinText;

    /** Called when the activity is first created. */
    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.main);
        
        convertButton = (Button) findViewById(R.id.convertButton);
        fahrenheitText = (EditText) findViewById(R.id.fahrenheitText);
        kelvinText = (EditText) findViewById(R.id.kelvinText);
        
        convertButton.setOnClickListener(this);
    }
   
    public void onClick(View v){
     // Convert fahrenheit to kelvin
     String f = fahrenheitText.getText().toString();
     Double fahrenheit = Double.parseDouble(f);
     Double kelvin = (5/9 * (fahrenheit - 32) + 273 );
     kelvinText.setText(String.valueOf(kelvin));
    }
}