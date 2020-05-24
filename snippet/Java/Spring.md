# Spring
---

### IoC容器
---

---
* 注解
    * @Component：定义了一个Bean，默认小写开头类名
    
         ```java
        @Component
        public class MailService {
            ...
        }
         ```
    
    * @Autowired：注入字段。如果是List，会自动把所有此类型的Bean装配为一个List注入进来；如果找不到对应类型的Bean，会抛出异常，可以用required = false参数忽略
        ```java
        @Component
        public class UserService {
            @Autowired(required=false)
            MailService mailService;
        
        }
         ```
    * @Configuration: 表示是一个配置类
    * @ComponentScan：告诉容器，自动搜索当前类所在的包以及子包，把所有标注为@Component的Bean自动创建出来，并根据@Autowired进行装配
    * @Value: 使用Resource对文件读取，@Value("classpath:/aaa.txt"),Resource 为org.springframework.core.io.Resource内的
    * @PropertySource：自动读取配置文件，k=v
        ```java
        @Configuration
        @ComponentScan
        @PropertySource("app.properties") // 表示读取classpath的app.properties
        public class AppConfig {
        public static void main(String[] args) {
            // 读取key为app.zone的value，但如果key不存在，就使用默认值Z
            @Value("${app.zone:Z}")
            String zoneId;

            ApplicationContext context = new AnnotationConfigApplicationContext(AppConfig.class);
            UserService userService = context.getBean(UserService.class);
            User user = userService.login("bob@example.com", "password");
            System.out.println(user.getName());
    }
}
         ```
    * 配置读取方式：通过Bean持有配置，需要注入的地方使用@Value("#{smtpConfig.host}"),意思为从smtpConfig这个Bean读取host的值，调用getHost方法
    * @Scope:生命周期，带参数
    * 初始化和销毁：初始化和资源清理通常定义init()和shutdown()方法并标记@PostConstruct和@PreDestroy
    * @Bean("name")：别名(不添加别名无法出现重复Bean定义)，也可以用@Bean+@Qualifier("name")，注入时要指定名称，否则抛出异常；可在Bean上添加@Primary，说明是主要Bean，不指定Bean的名字时会使用主要Bean
    * 按条件装配
    ```java
    @Profile：根据不同环境觉得是否装配
            ("!test"): 非测试环境
            ({"test", "master"}): 测试环境master分支
    @Conditional：根据条件觉得，需实现判断逻辑
    @ConditionalOnProperty(name="app.smtp", havingValue="true")：配置文件中存在app.smtp=true
    @ConditionalOnClass(name = "javax.mail.Transport"): 当前classpath中存在类javax.mail.Transport
    ```

---

### AOP

---
###### 名词解释
---
* Aspect：切面，即一个横跨多个核心逻辑的功能，或者称之为系统关注点；
* Joinpoint：连接点，即定义在应用程序流程的何处插入切面的执行；
* Pointcut：切入点，即一组连接点的集合；
* Advice：增强，指特定连接点上执行的动作；
* Introduction：引介，指为一个已有的Java对象动态地增加新的接口；
* Weaving：织入，指将切面整合到程序的执行流程中；
* Interceptor：拦截器，是一种实现增强的方式；
* Target Object：目标对象，即真正执行业务的核心逻辑对象；
* AOP Proxy：AOP代理，是客户端持有的增强后的对象引用。

---

###### 注解

---
* @EnableAspectJAutoProxy:加在@Configuration注解过的类上，Spring的IoC容器会自动查找带有@Aspect的Bean，然后根据每个方法的@Before、@Around等注解把AOP注入到特定的Bean中
    
    ```java
    @Aspect
@Component
public class LoggingAspect {
        // 在执行UserService的每个方法前执行:
        @Before("execution(public * com.itranswarp.learnjava.service.UserService.*(..))")
        public void doAccessCheck() {
            System.err.println("[Before] do access check...");
    }

        // 在执行MailService的每个方法前后执行:
        @Around("execution(public * com.itranswarp.learnjava.service.MailService.*(..))")
        public Object doLogging(ProceedingJoinPoint pjp) throws Throwable {
            System.err.println("[Around] start " + pjp.getSignature());
            Object retVal = pjp.proceed();
            System.err.println("[Around] done " + pjp.getSignature());
            return retVal;
    }
}
    
    ```
    
* @Before：这种拦截器先执行拦截代码，再执行目标代码。如果拦截器抛异常，那么目标代码就不执行了；
* @After：这种拦截器先执行目标代码，再执行拦截器代码。无论目标代码是否抛异常，拦截器代码都会执行；
* @AfterReturning：和@After不同的是，只有当目标代码正常返回时，才执行拦截器代码；
* @AfterThrowing：和@After不同的是，只有当目标代码抛出了异常时，才执行拦截器代码；
* @Around：能完全控制目标代码是否执行，并可以在执行前后、抛异常后执行任意拦截代码，可以说是包含了上面所有功能