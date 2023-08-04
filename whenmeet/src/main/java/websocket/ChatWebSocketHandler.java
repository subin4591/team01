package websocket;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketHandler;
import org.springframework.web.socket.WebSocketMessage;
import org.springframework.web.socket.WebSocketSession;

import com.fasterxml.jackson.databind.util.JSONPObject;

import dto.UserDTO;
import main.MainService;
import schedule.scheduleService;

@Component // autowired 가능
public class ChatWebSocketHandler implements WebSocketHandler{
	
	//채팅클라이언트 모아놓은 리스트
	List<WebSocketSession> list = new ArrayList();
	@Autowired
	private scheduleService service;
	
	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		// 웹소캣 연결시 1번 실행		
		list.add(session);
		System.out.println(
				"클라이언트 수= " + list.size() + " - " + session.getRemoteAddress() + "ip에서 접속"); 
		
	}

	@Override
	public void handleMessage(WebSocketSession session, WebSocketMessage<?> message) throws Exception {
		

		// 연결 도중 여러번 실행
		String msg = (String)message.getPayload();
		String text = msg.substring(0,msg.indexOf(":"));
		String date = msg.substring(msg.indexOf(":")+1,msg.indexOf(";"));
		String userId = msg.substring(msg.indexOf(";")+1);
		UserDTO dto = service.selectUserOne(userId);

		msg = "{"
		        + "\"id\":\"" + userId + "\","
		        + "\"text\":\"" + text + "\","
		        + "\"date\":\"" + date + "\","
		        + "\"profileimg\":\"" + dto.getProfile_url()+ "\","
		        + "\"name\":\"" + dto.getName() + "\""
		        + "}";
		
		// 접속 모든 클라이언트 메시지 송신
		for(WebSocketSession socket:list) {
			WebSocketMessage<String> sendmsg = new TextMessage(msg);
			socket.sendMessage(sendmsg);
			
		}
		
		
	}
	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus closeStatus) throws Exception {
		// 웹소캣 연결해제시 1번 실행
		list.remove(session);
		System.out.println(
				"클라이언트 수= " + list.size() + " - " + session.getRemoteAddress() + "ip에서 접속해제");
	}
	
	@Override
	public void handleTransportError(WebSocketSession session, Throwable exception) throws Exception {
		// 오류처리. 사용x
		 
	}

	

	@Override
	public boolean supportsPartialMessages() {
		//부가정보 생성, 사용x
		return false;
	}
	
}
