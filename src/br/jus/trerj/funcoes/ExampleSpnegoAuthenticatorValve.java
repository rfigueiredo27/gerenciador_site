package br.jus.trerj.funcoes;

import java.io.FileNotFoundException;
import java.io.IOException;
import java.net.URISyntaxException;
import java.security.Principal;
import java.security.PrivilegedActionException;
import java.util.HashMap;
import java.util.Map;

import javax.security.auth.login.LoginException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sourceforge.spnego.SpnegoAuthenticator;
import net.sourceforge.spnego.SpnegoHttpFilter.Constants;
import net.sourceforge.spnego.SpnegoHttpServletResponse;
import net.sourceforge.spnego.SpnegoPrincipal;

import org.apache.catalina.LifecycleException;
import org.apache.catalina.authenticator.AuthenticatorBase;
import org.apache.catalina.connector.Request;
import org.apache.catalina.connector.Response;
import org.apache.catalina.deploy.LoginConfig;
import org.ietf.jgss.GSSException;

public class ExampleSpnegoAuthenticatorValve extends AuthenticatorBase {
    private SpnegoAuthenticator authenticator = null;

    protected final boolean authenticate(final Request request, final Response response
            , final LoginConfig config) throws IOException {

        final HttpServletRequest httpRequest = (HttpServletRequest) request;
        final SpnegoHttpServletResponse spnegoResponse = new SpnegoHttpServletResponse(
                (HttpServletResponse) response);

            final SpnegoPrincipal principal;
            
            try {
                principal = this.authenticator.authenticate(httpRequest, spnegoResponse);
                
            } catch (GSSException e) {
                throw new IOException(e);
            }
            
            // context/auth loop not yet complete
            if (spnegoResponse.isStatusSet()) {
                return false;
            }
            
            // assert
            if (null == principal) {
                response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
                return false;
            }
            
            // now that we have a username, check if this username has any role(s) defined
            final Principal princ = this.context.getRealm().authenticate(
                    principal.getName(), "");
            
            if (null == princ) {
                // username may not have any roles or the wrong roles defined for the
                // the defined security realm (org.apache.catalina.Realm.java)
                response.setStatus(HttpServletResponse.SC_FORBIDDEN);
                return false;
            }
            
            this.register(request, response, princ, "SPNEGO", princ.getName(), "");

        return true;
    }
    
    @Override
    public final void start() throws LifecycleException {
        super.start();
        
        final Map<String, String> map = new HashMap<String, String>();
        map.put(Constants.ALLOW_BASIC, "true");
        map.put("spnego.allow.localhost", "true");
        map.put("spnego.allow.unsecure.basic", "true");
        map.put("spnego.login.client.module", "spnego-client");
        map.put("spnego.krb5.conf", "krb5.conf");
        map.put("spnego.login.conf", "login.conf");
        map.put("spnego.preauth.username", "Zeus");
        map.put("spnego.preauth.password", "Z3usP@55");
        map.put("spnego.login.server.module", "spnego-server");
        map.put("spnego.prompt.ntlm", "true");
        map.put("spnego.allow.delegation", "true");
        map.put("spnego.logger.level", "1");
        
        try {
            authenticator = new SpnegoAuthenticator(map);
        } catch (LoginException e) {
            throw new LifecycleException(e);
        } catch (FileNotFoundException e) {
            throw new LifecycleException(e);
        } catch (GSSException e) {
            throw new LifecycleException(e);
        } catch (PrivilegedActionException e) {
            throw new LifecycleException(e);
        } catch (URISyntaxException e) {
            throw new LifecycleException(e);
        }
    }
    
    @Override
    public final void stop() throws LifecycleException {
        super.stop();
        
        if (null != this.authenticator) {
            this.authenticator.dispose();
        }
    }

	@Override
	public boolean authenticate(Request arg0, HttpServletResponse arg1,
			LoginConfig arg2) throws IOException {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	protected String getAuthMethod() {
		// TODO Auto-generated method stub
		return null;
	}
}