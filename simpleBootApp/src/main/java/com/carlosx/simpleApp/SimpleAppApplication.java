package com.carlosx.simpleApp;

import java.io.PrintStream;

import org.springframework.boot.Banner;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.core.env.Environment;

@SpringBootApplication
public class SimpleAppApplication {

	public static void main(String[] args) {
		//SpringApplication.run(SimpleAppApplication.class, args);
		SpringApplication app = new SpringApplication(SimpleAppApplication.class);
		app.setBanner(new Banner () {
			/*
			 * This configuration is overriden if Spring finds a banner.txt
			 * Also this config can be overriden by setting VM property change, adding: 
			 * -Dspring.banner.location=classpath:/META-INF/banner.txt
			 * for this example or 
			 * -Dspring.banner.location=classpath:/PathToBannerFromClassPath/banner.txt
			 * for another location that starts from classpath
			 * another configuration is to disable the banner using application.properties
			 * spring.main.banner-mode=off
			 * Also you can swith it off!!! using app.setBannerMode(Banner.Mode.OFF);
			 */
			@Override
			public void printBanner (Environment environment, Class<?> sourceClass, PrintStream out) {
				out.println("                 ,--.              ,----..    \n" + 
						"   ,---,       ,--.'|    ,---,.   /   /   \\   \n" + 
						",`--.' |   ,--,:  : |  ,'  .' |  /   .     :  \n" + 
						"|   :  :,`--.'`|  ' :,---.'   | .   /   ;.  \\ \n" + 
						":   |  '|   :  :  | ||   |   .'.   ;   /  ` ; \n" + 
						"|   :  |:   |   \\ | ::   :  :  ;   |  ; \\ ; | \n" + 
						"'   '  ;|   : '  '; |:   |  |-,|   :  | ; | ' \n" + 
						"|   |  |'   ' ;.    ;|   :  ;/|.   |  ' ' ' : \n" + 
						"'   :  ;|   | | \\   ||   |   .''   ;  \\; /  | \n" + 
						"|   |  ''   : |  ; .''   :  '   \\   \\  ',  /  \n" + 
						"'   :  ||   | '`--'  |   |  |    ;   :    /   \n" + 
						";   |.' '   : |      |   :  \\     \\   \\ .'    \n" + 
						"'---'   ;   |.'      |   | ,'      `---`      \n" + 
						"        '---'        `----'                   ");
			}
		});
		app.setBannerMode(Banner.Mode.OFF); //Even when I set a new banner, if i disable it doesn't show
		app.run(args);
	}

}
