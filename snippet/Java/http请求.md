# apache
* post
    ```java
    /**
    <dependency>
        <groupId>org.apache.httpcomponents</groupId>
        <artifactId>httpclient</artifactId>
        <version>4.5.12</version>
    </dependency>
    **/

    import org.apache.http.HttpEntity;
    import org.apache.http.NameValuePair;
    import org.apache.http.client.config.RequestConfig;
    import org.apache.http.client.methods.CloseableHttpResponse;
    import org.apache.http.client.methods.HttpPost;
    import org.apache.http.client.utils.URIBuilder;
    import org.apache.http.entity.StringEntity;
    import org.apache.http.impl.client.CloseableHttpClient;
    import org.apache.http.impl.client.HttpClients;
    import org.apache.http.message.BasicNameValuePair;
    import org.apache.http.util.EntityUtils;
    
    import java.io.IOException;
    import java.net.URISyntaxException;
    import java.nio.charset.Charset;
    import java.util.ArrayList;
    import java.util.List;
    import java.util.Map;
    
    /**
     * @author xinsuishang
     * @description TODO
     * @date 2020/5/20 18:28
     */
    public class HttpUtils {
        public static String post(String url, Map<String, String> params, String body) throws URISyntaxException, IOException {
            URIBuilder builder = new URIBuilder(url);
            // 拼接到地址栏的参数
    
            if (params != null && params.size() > 0) {
                List<NameValuePair> pairList = new ArrayList<>();
                for (Map.Entry<String, String> entry : params.entrySet()) {
                    pairList.add(new BasicNameValuePair(entry.getKey(), entry.getValue()));
                }
                builder.setParameters(pairList);
            }
    
            HttpPost httpPost = new HttpPost(builder.build());
            //body
            if (body != null && body.length() > 0){
                HttpEntity entity = new StringEntity(body, Charset.forName("UTF-8"));
                httpPost.setEntity(entity);
            }
    
            RequestConfig config = RequestConfig.custom()
                    // 设置连接超时时间, 单位毫秒
                    .setConnectTimeout(2000)
                    // 请求获取数据的超时时间, 单位毫秒
                    // 如果访问一个接口, 多少时间内无法返回数据, 就直接放弃此次调用
                    .setSocketTimeout(5000)
                    .build();
            httpPost.setConfig(config);
            // 请求头
            httpPost.setHeader("Content-Type", "application/json; charset=utf-8");
            // http连接
            CloseableHttpClient client = HttpClients.createDefault();
            // 发http请求
            CloseableHttpResponse response = client.execute(httpPost);
            // 状态吗
            int code = response.getStatusLine().getStatusCode();
            // 内容
            return EntityUtils.toString(response.getEntity());
        }
    }
```