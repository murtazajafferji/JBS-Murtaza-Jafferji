package edu.brandeis.cs.jafferji;

import android.app.Activity;
import android.os.Bundle;

/** 
 * @author Murtaza Jafferji
 * About class
 * Sets the content view to about.
 * Overrides the onCreate method.
 */
public class About extends Activity {
	@Override
	protected void onCreate(Bundle savedInstanceState) {
			super.onCreate(savedInstanceState);
				setContentView(R.layout.about);
	}
}