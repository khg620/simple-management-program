package study.crud.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class HomeController {

	@RequestMapping(value="/", method=RequestMethod.GET)
	public String main() {
		//System.out.println(request.getServletContext().getRealPath("/")); //테스트용 경로(이클립스 상 실행 시 실제 경로)
		return "redirect:/main";
	}
}
