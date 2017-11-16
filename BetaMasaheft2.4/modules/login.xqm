xquery version "3.1" encoding "UTF-8";
(:~
 : module used by the app for login and logout
 : 
 : @author Pietro Liuzzo <pietro.liuzzo@uni-hamburg.de'>
 :)
module namespace locallogin="https://www.betamasaheft.eu/login";
import module namespace config = "https://www.betamasaheft.uni-hamburg.de/BetMas/config" at "../modules/config.xqm";
import module namespace request = "http://exist-db.org/xquery/request";
import module namespace console = "http://exist-db.org/xquery/console";

declare variable $locallogin:login :=
    let $tryImport :=
        try {
            util:import-module(xs:anyURI("http://exist-db.org/xquery/login"), 
            "login", xs:anyURI("resource:org/exist/xquery/modules/persistentlogin/login.xql")),
            true()
        } catch * {
            false()
        }
    return
        if ($tryImport) then
            function-lookup(xs:QName("login:set-user"), 3)
           
        else
            locallogin:fallback-login#3
;



(:~
    Fallback login function used when the persistent login module is not available.
    Stores user/password in the HTTP session.
 :)
declare function locallogin:fallback-login($domain as xs:string, $maxAge as xs:dayTimeDuration?, $asDba as xs:boolean) {
    let $user := request:get-parameter("user", ())
    let $password := request:get-parameter("password", ())
    let $logout := request:get-parameter("logout", ())
    return
        if ($logout) then
            (
            session:invalidate(),
             console:log('logout'),
             console:log('I have just logged out. This list of SESSION attributes should be empty ' ||string-join(session:get-attribute-names(), ' '))
                        
             )
       else
            if ($user) then
                let $isLoggedIn := xmldb:login("/db", $user, $password, true())
                return (
                        session:set-attribute("BetMas.user", $user),
                        session:set-attribute("BetMas.password", $password),
                        request:set-attribute($domain || ".user", $user),
                        request:set-attribute("xquery.user", $user),
                        request:set-attribute("xquery.password", $password),
                        console:log(if(session:exists()) then 'yes' else 'no'),
                        console:log('I have just set user param. These are the REQUEST attributes ' ||string-join(request:attribute-names(), ' ')),
                        console:log('I have just set user param. These are the SESSION attributes ' ||string-join(session:get-attribute-names(), ' '))
                        
                        )
                   
            else
             let $test := console:log('isNotLogged')
                let $user := session:get-attribute("BetMas.user")
                let $password := session:get-attribute("BetMas.password")
                return (
                    request:set-attribute($domain || ".user", $user),
                    request:set-attribute("xquery.user", $user),
                    request:set-attribute("xquery.password", $password),
                        console:log('No user param. These are the REQUEST attributes ' || string-join(request:attribute-names(), ' ')),
                        console:log('No user param. These are the SESSION attributes' || string-join(session:get-attribute-names(), ' '))
                )
};

declare function locallogin:user-allowed() {
    (
        request:get-attribute("org.exist.login.user") and
        request:get-attribute("org.exist.login.user") != "guest"
    ) or config:get-configuration()/restrictions/@guest = "yes"
};


declare function locallogin:logout(){
$locallogin:login("org.exist.login", (), false())
};

declare function locallogin:loginhere(){
$locallogin:login("org.exist.login", (), false())
};


(:~ login function to be called from navigation template. if the user is guest, then show login, if not it is a logged user, then show logout:)
declare function locallogin:login(){  
 if(xmldb:get-current-user() = 'guest') then
 <li class="dropdown">
          <a href="#" 
          class="dropdown-toggle" 
          data-toggle="dropdown"><b>Login</b> 
          <span class="caret"></span></a>
			<ul id="login-dp" class="dropdown-menu">
				<li>
		 <div class="row">
			<div class="col-md-12">
			<form method="post" class="form" role="form" accept-charset="UTF-8" id="login-nav">
                    <div class="form-group">
                        <label class="control-label col-md-1" for="user">User:</label>
                            <input type="text" name="user" required="required" class="form-control"/>
                        
                    </div>
                    <div class="form-group">
                        <label class="control-label col-md-1" for="password">Password:</label>
                            <input type="password" name="password" class="form-control"/>
                        
                    </div>
                    
                    <div class="form-group">
                        <div class="col-md-offset-1 col-sm-12">
                            <button class="btn btn-primary" type="submit">Login</button>
                          			
                        </div>  
                    </div>
                </form>
							</div>
							 </div>
				</li>
				
			</ul>
        </li>
                else
              <li  class="dropdown"> 
              <form method="post" action="/auth/logout.xql" class="form" role="form" accept-charset="UTF-8" id="logout-nav">
                <div class="form-group">
                        <div class="col-md-offset-1 col-sm-12">
              <button  class="btn btn-primary" type="submit">Logout</button>
              </div>
              </div>
              <input value="true" name="logout" class="form-control" type="hidden"/>
                        
              </form>
              </li>
}; 