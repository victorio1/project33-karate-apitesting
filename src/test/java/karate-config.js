function fn() {
  karate.configure('connectTimeout', 25000);
  karate.configure('logPrettyResponse', true);

  var env = karate.env; // get system property 'karate.env'
  karate.log('karate.env system property was:', env);
  if (!env) {
    env = 'localhost';
  }
  var config = {
    env: env,
	myVarName: 'someValue'
  }
  if (env == 'localhost') {
    // customize
    // e.g. config.foo = 'bar';
    config.urlApp = 'http://bc22abeeec88.ngrok.io';
  } else if (env == 'dev') {
    // customize
    config.urlApp = 'http://dev:8081';
  } else if (env == 'qa') {
    config.urlApp = 'http://qa.8081';
  }


  return config;
}