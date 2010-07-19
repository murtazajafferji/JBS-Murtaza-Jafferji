package root.magicword;

import java.util.List;
import java.util.Random;
import root.magicword.speech.SpeechGatheringActivity;
import root.magicword.speech.TextSpeakerAndroid;
import android.os.Bundle;
import android.speech.tts.TextToSpeech.OnUtteranceCompletedListener;
import android.view.View;
import android.widget.Button;
import android.widget.TextView;

/**
 * 
 * @author Murtaza Jafferji
 * User must guess the magic word
 * The speaker will tell the user if the heard word is longer or shorter
 * than the magic word. If the word is the same length, then the speaker
 * will tell which positions, if any, the characters are the same.
 */
public class MagicWord extends SpeechGatheringActivity implements OnUtteranceCompletedListener
{
    private TextSpeakerAndroid speaker;
    private Random randomgenerator= new Random();
    private TextView result;

    /** Called when the activity is first created. */
    @Override
    public void onCreate(Bundle savedInstanceState) 
    {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.main);
        
        speaker = new TextSpeakerAndroid(this);
        
        Button speak = (Button)findViewById(R.id.bt_speak);
        speak.setOnClickListener(new View.OnClickListener()
        {
            @Override
            public void onClick(View v)
            {
               gatherSpeech();
            }
        });
        
        result = (TextView)findViewById(R.id.tv_result);
    }
    
    @Override
    public void onUtteranceCompleted(String utteranceId)
    {
        //done speaking, execute some ui updates on the UIthread
    }
    
    public void receiveWhatWasHeard(List<String> lastThingsHeard)
    {
        if (lastThingsHeard.size() == 0)
        {
            speaker.say("Heard nothing", this);
        }
        else
        {
            String mostLikelyThingHeard = lastThingsHeard.get(0);
            String magicWord = this.getResources().getString(R.string.magicword);
            if (mostLikelyThingHeard.equals(magicWord))
            {
                speaker.say("You said the magic word!", this);
            }
            else
            {
            	/** 
            	 * Tells the user if his word is longer, shorter, or the same
            	 * length as the magic word. If it is the same length, it will
            	 * tell the user in which position the characters match.
            	 */
            	if (mostLikelyThingHeard.length() > magicWord.length()){
            		speaker.say("The magic word has more letters in it than the word" + mostLikelyThingHeard + ". Try again.", this);
            	}
            	else if (mostLikelyThingHeard.length() < magicWord.length()){
            		speaker.say("The magic word has less letters in it than the word" + mostLikelyThingHeard + ". Try again.", this);
            	}
            	else{
            		char[] magicWordArray =  magicWord.toCharArray();
            		char[] mostLikelyArray = mostLikelyThingHeard.toCharArray();
            		String matchedPositions = "";
            		for (int i = 0; i < magicWord.length(); i++){
            			if (mostLikelyArray[i] == magicWordArray[i]){
            				matchedPositions += (i + 1) + " ";
            			}
            		}
            		speaker.say("The magic word has the same number of letters in it than the word" + mostLikelyThingHeard + " in the positions " + matchedPositions + ". Try again.", this);
            	}
            }
        }
        result.setText("heard: " + lastThingsHeard);
    }

    
}