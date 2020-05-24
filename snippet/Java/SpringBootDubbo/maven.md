# Maven
* partner
    * pom.xml
        
        ```xml
        <parent>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-parent</artifactId>
            <version>2.3.0.RELEASE</version>
            <relativePath/> <!-- lookup parent from repository -->
    </parent>

        <properties>
            <project.build.sourceEncoding>UTF-8</project.build.sourceEncoding>
            <project.reporting.outputEncoding>UTF-8</project.reporting.outputEncoding>
            <maven.compiler.source>1.8</maven.compiler.source>
            <maven.compiler.target>1.8</maven.compiler.target>
            <java.version>1.8</java.version>
            <dubbo.starter.version>2.7.6</dubbo.starter.version>
            <zkclient.version>0.10</zkclient.version>
            <spring.boot.version>2.3.0.RELEASE</spring.boot.version>
    </properties>
    ```
    
* api
    * pom.xml

* consumer
    * pom.xml
    * application.properties
    
        ```
        server.port=8081
        dubbo.application.name=dubbo_consumer
        dubbo.registry.protocol=zookeeper
        dubbo.registry.address=zookeeper://127.0.0.1:2181
    ```
    * main
    
        ```java
        @SpringBootApplication
public class SpringBootDemoDubboConsumerApplication {
    public static void main(String[] args) {
            SpringApplication.run(SpringBootDemoDubboConsumerApplication.class, args);
            }
}
    ```
    
* provider
    * pom.xml
    * application.properties
        
        ```
spring.application.name=dubbo_auto_configuration_provider_demo
dubbo.application.name=dubbo_provider
dubbo.registry.protocol=zookeeper
dubbo.registry.address=zookeeper://127.0.0.1:2181
dubbo.protocol.name=dubbo
dubbo.protocol.port=20880
<!--api的package-->
dubbo.scan.base-packages=com.trace
    ```
    * main
    
        ```java
        @SpringBootApplication
public class SpringBootDemoDubboProviderApplication {
    public static void main(String[] args) {
            SpringApplication.run(SpringBootDemoDubboProviderApplication.class, args);
            }
}
    ```