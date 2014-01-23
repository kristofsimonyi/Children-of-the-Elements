package com.childrenoftheelements.story.stories;

import android.app.Activity;
import android.app.ActionBar;
import android.app.Fragment;
import android.content.Intent;
import android.os.Bundle;
import android.util.Log;
import android.view.LayoutInflater;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;
import android.view.ViewGroup;
import android.os.Build;

import com.childrenoftheelements.story.R;

import java.util.Timer;
import java.util.TimerTask;
import java.util.logging.Handler;

public class StoryFirst extends Activity {

    private Timer autoUpdate;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

        setContentView(R.layout.activity_story_first);

        if (savedInstanceState == null) {
            getFragmentManager().beginTransaction()
                    .add(R.id.container, new PlaceholderFragment())
                    .commit();
        }

        refreshTimer();
    }


    @Override
    public boolean onCreateOptionsMenu(Menu menu) {
        
        // Inflate the menu; this adds items to the action bar if it is present.
        getMenuInflater().inflate(R.menu.story_first, menu);
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
            View rootView = inflater.inflate(R.layout.fragment_story_first, container, false);
            return rootView;
        }
    }


    private void refreshTimer() {
        autoUpdate  = new Timer();
        autoUpdate.schedule(new TimerTask() {
            @Override
            public void run() {
                runOnUiThread(new Runnable() {
                    public void run() {

                        autoUpdate.cancel();
                        pasarDeActivity();

                    }
                });
            }
        }, 5000, 100);

    }

    public void  pasarDeActivity(){

        Intent intent = new Intent(StoryFirst.this, StorySecond.class);

        startActivity(intent);

        overridePendingTransition(R.animator.fade_in, R.animator.fade_out);

        /*
        * Intent intent = new Intent(MainActivity.this,  WorldMap.class );

            startActivity(intent);

            overridePendingTransition(R.animator.fade_in, R.animator.fade_out);
        *
        * */

    }


}
