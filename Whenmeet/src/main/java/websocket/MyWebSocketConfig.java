package websocket;

import org.springframework.context.annotation.Configuration;
import org.springframework.web.socket.config.annotation.EnableWebSocket;
import org.springframework.web.socket.config.annotation.WebSocketConfigurer;
import org.springframework.web.socket.config.annotation.WebSocketHandlerRegistry;

import lombok.RequiredArgsConstructor;

@Configuration
@EnableWebSocket
public class MyWebSocketConfig implements WebSocketConfigurer{
	
	final ChatWebSocketHandler handler;
	
	public MyWebSocketConfig(final ChatWebSocketHandler handler) {
	      this.handler = handler;
	}
	
	@Override
	public void registerWebSocketHandlers(WebSocketHandlerRegistry registry) {
		// TODO Auto-generated method stub
		registry.addHandler(handler, "/chatws").setAllowedOrigins("*");
	}
	
	
	
	
}
