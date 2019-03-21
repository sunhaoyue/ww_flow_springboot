package com.wantwant.config;

import org.apache.catalina.filters.RemoteIpFilter;
import org.springframework.boot.web.servlet.FilterRegistrationBean;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import javax.servlet.*;
import java.io.IOException;

//@Configuration
public class WebConfiguration {
    @Bean
    public RemoteIpFilter remotelpFilter(){
        return new RemoteIpFilter();
    }
    @Bean
    public FilterRegistrationBean testFilterRegistration(){
        FilterRegistrationBean registration=new FilterRegistrationBean();
        registration.setFilter(new MyFilter());
        registration.addInitParameter("paramName","paranValue");
        registration.setName("MyFilter");
        registration.setOrder(1);
        return registration;
    }
    public class MyFilter implements Filter {

        @Override
        public void init(FilterConfig filterConfig) throws ServletException {

        }

        @Override
        public void doFilter(ServletRequest servletRequest, ServletResponse servletResponse, FilterChain filterChain) throws IOException, ServletException {
            
        }

        @Override
        public void destroy() {

        }
    }
}
