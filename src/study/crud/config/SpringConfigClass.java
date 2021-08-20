package study.crud.config;

import javax.servlet.Filter;
import javax.servlet.MultipartConfigElement;
import javax.servlet.ServletRegistration.Dynamic;

import org.springframework.web.filter.CharacterEncodingFilter;
/*
1. WebApplicationInitializer 인터페이스를 구현하여 세팅
public class SpringConfigClass implements WebApplicationInitializer {

	//web.xml을 로딩하는 대신에 이 메소드를 자동으로 호출
	//web.xml에서 작업했던 내용을 여기서 자바코드로 구현
	@Override
	public void onStartup(ServletContext servletContext) throws ServletException {
		//Spring MVC 프로젝트 설정 코드를 작성할 클래스의 객체를 생성한다
		AnnotationConfigWebApplicationContext servletAppContext = new AnnotationConfigWebApplicationContext();
		servletAppContext.register(ServletAppContext.class);
		
		//요청 발생 시 요청을 처리하는 서블릿을 DispatcherServlet으로 설정해준다
		DispatcherServlet dispatcherServlet = new DispatcherServlet(servletAppContext);
		
		ServletRegistration.Dynamic servlet = servletContext.addServlet("dispatcher", dispatcherServlet);
	
		//부가설정
		servlet.setLoadOnStartup(1); //모든 요청에 대해 가장 먼저 로드하겠다
		servlet.addMapping("/");
		
		//사용할 빈을 정의할 클래스를 지정
		AnnotationConfigWebApplicationContext rootAppContext = new AnnotationConfigWebApplicationContext();
		rootAppContext.register(RootAppContext.class);
		
		//리스너 설정
		ContextLoaderListener listener = new ContextLoaderListener(rootAppContext);
		servletContext.addListener(listener);
		
		//파라미터 인코딩 설정
		//dispatcher란 이름으로 등록된 서블릿이 받아들이는 요청에 대해서 인코딩 필터를 통과시키겠다.
		FilterRegistration.Dynamic filter = servletContext.addFilter("encodingFilger", CharacterEncodingFilter.class);
		filter.setInitParameter("encoding", "UTF-8");
		filter.addMappingForServletNames(null, false, "DISPATCHER");
	}

}
*/
//2. AbstractAnnotationConfigDispatcherServletInitializer 로 세팅하는 방법
//  (위 방식보다 코드가 짧아지는 대신 자유도가 떨어짐)
import org.springframework.web.servlet.support.AbstractAnnotationConfigDispatcherServletInitializer;
//public class SpringConfigClass implements WebApplicationInitializer{
//
//	@Override
//	public void onStartup(ServletContext servletContext) throws ServletException {
//		
//		// Spring MVC 프로젝트 설정을 위해 작성하는 클래스의 객체를 생성한다.
//		AnnotationConfigWebApplicationContext servletAppContext = new AnnotationConfigWebApplicationContext();
//		servletAppContext.register(ServletAppContext.class);
//
//		// 요청 발생 시 요청을 처리하는 서블릿을 DispatcherServlet으로 설정해준다.
//		DispatcherServlet dispatcherServlet = new DispatcherServlet(servletAppContext);
//		ServletRegistration.Dynamic servlet = servletContext.addServlet("dispatcher", dispatcherServlet);
//
//		// 부가 설정
//		servlet.setLoadOnStartup(1);
//		servlet.addMapping("/");
//
//		// Bean을 정의하는 클래스를 지정한다
//		AnnotationConfigWebApplicationContext rootAppContext = new AnnotationConfigWebApplicationContext();
//		rootAppContext.register(RootAppContext.class);
//
//		ContextLoaderListener listener = new ContextLoaderListener(rootAppContext);
//		servletContext.addListener(listener);
//
//		// 파라미터 인코딩 설정
//		FilterRegistration.Dynamic filter = servletContext.addFilter("encodingFilter", CharacterEncodingFilter.class);
//		filter.setInitParameter("encoding", "UTF-8");
//		filter.addMappingForServletNames(null, false, "dispatcher");
//	}
//}
public class SpringConfigClass extends AbstractAnnotationConfigDispatcherServletInitializer {

	// DispatcherServlet에 매핑할 요청 주소를 세팅한다
	@Override
	protected String[] getServletMappings() {

		return new String[] { "/" }; // 모든 요청 주소에 대해 dispatcherServlet이 반응하게 하겠다
	}

	// Spring MVC 프로젝트 설정을 위한 클래스를 지정
	@Override
	protected Class<?>[] getServletConfigClasses() {

		return new Class[] { ServletAppContext.class };
	}

	// 프로젝트에서 사용할 Bean들을 정의하기 위한 클래스 지정한다
	@Override
	protected Class<?>[] getRootConfigClasses() {

		return new Class[] { RootAppContext.class };
	}

	// 파라미터 인코딩 필터 설정
	@Override
	protected Filter[] getServletFilters() {
		CharacterEncodingFilter encodingFilter = new CharacterEncodingFilter();
		encodingFilter.setEncoding("UTF-8");
		return new Filter[] { encodingFilter };// 필터를 여러 개 세팅할 수 있기 때문에 배열로 반환
	}

	//form 태그의 enctype="multipart/form-data" 설정 시 데이타를 다 받을 수 있도록 설정
	@Override
	protected void customizeRegistration(Dynamic registration) {
		super.customizeRegistration(registration);
	
		MultipartConfigElement config1 = new MultipartConfigElement(null, 52428800, 524288000, 0);
				//첫번째 매개변수 : 클라이언트가 보낼 파일 데이터 임시 저장할 경로값 -> null 지정 시 톰캣에서 정한 임시 폴더로 세팅됨
				//두번째 매개변수 : 업로드하는 파일의 최대 용량(바이트 단위) 1024*1024*50 (50메가)
				//세번째 : 전체 요청 정보의 최대 용량
				//네번째 : 인계값 -> 0 지정 시 데이터를 받아서 알아서 저장하겠다
		registration.setMultipartConfig(config1);
	}
}

