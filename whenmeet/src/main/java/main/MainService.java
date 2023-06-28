package main;

import java.util.List;

public interface MainService {
	public List<String> myApplication(String user_id);
	public List<String> myWrite(String user_id);
	public List<String> myGroup(String user_id);
	public List<String> rankList();
}
