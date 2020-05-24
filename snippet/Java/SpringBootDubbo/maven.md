# Maven
* partner
    * pom.xml
        
        ```xml
        <!--配置-->
        <properties>
            <project.build.sourceEncoding>UTF-8</project.build.sourceEncoding>
            <project.reporting.outputEncoding>UTF-8</project.reporting.outputEncoding>
            <maven.compiler.source>14</maven.compiler.source>
            <maven.compiler.target>14</maven.compiler.target>
            <java.version>14</java.version>
            <dubbo.version>2.7.6</dubbo.version>
            <curator.version>4.3.0</curator.version>
            <zkclient.version>0.10</zkclient.version>
    </properties>

        <!-- spring-boot父级引用 -->
        <parent>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-parent</artifactId>
            <version>2.3.0.RELEASE</version>
            <relativePath/>
    </parent>

        <dependencyManagement>
        <dependencies>
            <!-- dubbo-start依赖 -->
                <dependency>
                    <groupId>org.apache.dubbo</groupId>
                    <artifactId>dubbo-spring-boot-starter</artifactId>
                    <version>${dubbo.version}</version>
                    <exclusions>
                        <exclusion>
                            <groupId>org.slf4j</groupId>
                            <artifactId>slf4j-log4j12</artifactId>
                        </exclusion>
                    </exclusions>
                </dependency>

                <dependency>
                    <groupId>com.101tec</groupId>
                    <artifactId>zkclient</artifactId>
                    <version>${zkclient.version}</version>
                    <exclusions>
                        <exclusion>
                            <artifactId>zookeeper</artifactId>
                            <groupId>org.apache.zookeeper</groupId>
                        </exclusion>
                    </exclusions>
                </dependency>
            </dependencies>
        </dependencyManagement>
    <dependencies>
    <!-- spring boot 依赖 -->
            <dependency>
                <groupId>org.springframework.boot</groupId>
                <artifactId>spring-boot-starter</artifactId>
            </dependency>
    </dependencies>

        <!-- 打包插件 -->
        <build>
            <plugins>
                <plugin>
                    <groupId>org.springframework.boot</groupId>
                    <artifactId>spring-boot-maven-plugin</artifactId>
                </plugin>
            </plugins>
        </build>
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