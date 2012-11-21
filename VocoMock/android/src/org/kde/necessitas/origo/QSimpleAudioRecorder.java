package org.kde.necessitas.origo;


import android.media.MediaRecorder;
import android.util.Log;

public class QSimpleAudioRecorder {

	MediaRecorder m_MediaRecorder;

	public QSimpleAudioRecorder() {
		m_MediaRecorder = new MediaRecorder();
	}

	boolean setUrl(String path) {

                Log.i("Error Bitch", path);

		try {
			m_MediaRecorder.setAudioSource(MediaRecorder.AudioSource.MIC);
			m_MediaRecorder.setOutputFormat(MediaRecorder.OutputFormat.THREE_GPP);
			m_MediaRecorder.setAudioEncoder(MediaRecorder.AudioEncoder.DEFAULT);
			m_MediaRecorder.setAudioChannels(2);
			m_MediaRecorder.setAudioEncodingBitRate(128);
			m_MediaRecorder.setAudioSamplingRate(44100);
			m_MediaRecorder.setOutputFile(path);
		} catch (Exception e) {
			e.printStackTrace();
            return false;
		}
		return true;
	}


	boolean record() {
		try {
			m_MediaRecorder.prepare();
		} catch (Exception e) {
			e.printStackTrace();
            return false;
		}
		m_MediaRecorder.start();
		return true;
	}


	boolean stop() {
		
		try {
			m_MediaRecorder.stop();
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
		return true;
	}

	boolean release() {
		m_MediaRecorder.reset();
		try {
			m_MediaRecorder.release();
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
		return true;
	}
	public static native int addTwoNumbers(int a, int b);
}
