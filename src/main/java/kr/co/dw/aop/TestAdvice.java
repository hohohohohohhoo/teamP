package kr.co.dw.aop;

import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Before;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import kr.co.dw.service.reply.ReplyService;

@Component
@Aspect
public class TestAdvice {
	@Autowired
	private ReplyService rService;
	
	@Before("execution(* kr.co.dw.service.test.TestService*.*(..))")
	public void start(JoinPoint jp) {
		System.out.println("^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^");
		
		Object[] arr = jp.getArgs();
		for(int i =0; i<arr.length;i++) {
			System.out.println(arr[i]);
		}
	}

	@Around("execution(* kr.co.dw.service.test.TestService*.*(..))")
	public Object testTime(ProceedingJoinPoint pjp) throws Throwable {
		long before = System.currentTimeMillis();
		
		Object obj = pjp.proceed();
		
		long after = System.currentTimeMillis();
		
		System.out.println(after - before);
		
		return obj;
	}
	
//	@Around("execution(* kr.co.dw.service.board.BoardService*.delete(..))")
//	public Object deleteReply(ProceedingJoinPoint pjp) throws Throwable {
//		
//		Object[] arr = pjp.getArgs();
//				
//		rService.deleteByBno(arr[0]);
//		
//		
//		Object obj = pjp.proceed();
//		
//
//		
//		return obj;
//	}
	
	
}
