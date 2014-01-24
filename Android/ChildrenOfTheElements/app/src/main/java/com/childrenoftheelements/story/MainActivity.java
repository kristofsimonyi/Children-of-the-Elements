package com.childrenoftheelements.story;

import android.app.Activity;
import android.app.Fragment;
import android.content.Intent;
import android.graphics.Typeface;
import android.media.MediaPlayer;
import android.media.SoundPool;
import android.os.Bundle;
import android.view.LayoutInflater;
import android.view.Menu;
import android.view.MenuItem;
import android.view.MotionEvent;
import android.view.View;
import android.view.ViewGroup;
import android.widget.TextView;


public class MainActivity extends Activity {

    private SoundPool soundPool;
    private int soundID;
    boolean loaded = false;

    private MediaPlayer mp;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);





        MediaPlayer mp = new MediaPlayer();

        TextView titular = (TextView) findViewById(R.id.start_mainTitle);
        TextView subtitle = (TextView) findViewById(R.id.start_subtitle);

        Typeface estilo = Typeface.createFromAsset( getAssets(), "fonts/rugeboogie.ttf");

        titular.setTypeface(estilo);
        subtitle.setTypeface(estilo);


        /*
        this.setVolumeControlStream( AudioManager.STREAM_MUSIC);
        soundPool = new SoundPool(30, AudioManager.STREAM_MUSIC, 0);
        soundPool.setOnLoadCompleteListener( new SoundPool.OnLoadCompleteListener() {
            @Override
            public void onLoadComplete(SoundPool soundPool, int sampleId , int status) {
                loaded = true;
            }
        });
        soundID = soundPool.load(this, R.raw.sea , 1);
        */

    }


    @Override
    public boolean onCreateOptionsMenu(Menu menu) {
        
        // Inflate the menu; this adds items to the action bar if it is present.
        getMenuInflater().inflate(R.menu.main, menu);
        return true;
    }

    @Override
    public boolean onOptionsItemSelected(MenuItem item) {
        // Handle action bar item clicks here. The action bar will
        // automatically handle clicks on the Home/Up button, so long
        // as you specify a parent activity in AndroidManifest.xml.
        int id = item.getItemId();
        if (id == R.id.action_settings) {
            return true;
        }
        return super.onOptionsItemSelected(item);
    }

    /**
     * A placeholder fragment containing a simple view.
     */
    public static class PlaceholderFragment extends Fragment {

        public PlaceholderFragment() {
        }

        @Override
        public View onCreateView(LayoutInflater inflater, ViewGroup container,
                Bundle savedInstanceState) {
            View rootView = inflater.inflate(R.layout.fragment_main, container, false);
            return rootView;
        }
    }

    @Override
    public boolean onTouchEvent(MotionEvent event){
        // MotionEvent object holds X-Y values
        if(event.getAction() == MotionEvent.ACTION_DOWN) {

            musiquita();

            Intent intent = new Intent(MainActivity.this,  WorldMap.class );

            startActivity(intent);

            overridePendingTransition(R.animator.fade_in, R.animator.fade_out);

        }

        return super.onTouchEvent(event);


    }

    private void musiquita(){




            mp = MediaPlayer.create(getApplicationContext(), R.raw.sea);
            mp.setLooping(true);
            //mp.start();



        /*
        AudioManager audioManager = (AudioManager) getSystemService( AUDIO_SERVICE);
        float actualVolume = (float) audioManager.getStreamVolume(AudioManager.STREAM_MUSIC);
        float maxVolume = (float) audioManager.getStreamMaxVolume( AudioManager.STREAM_MUSIC);
        float volume = actualVolume / maxVolume;

        if(loaded){
            soundPool.play( soundID, volume, volume, 1, 0, 1f);
            Log.e("TEST", "Played Sound");
        }
        */


    }

    private void apagarMusica(){

        mp.stop();

    }








}
