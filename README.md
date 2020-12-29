# neptune-hande-on-ajax
Clean HANDLE_ON_AJAX method for Neptune Add-On development

Neptune Software DXP P8 (SAP edition) handles AJAX-calls from frontend using the HANDLE_ON_AJAX method as defined by the /NEPTUNE/IF_NAD_SERVER interface.

Typically, this method is seen implemented using a big CASE statement, making it long, repetetive and not very ‘clean’.

And I have been found guilty as charged as well here, but nowadays I use dynamic ABAP and a structured, consistent approach to this method instead and I’m happy to share it.

- The ‘structured and consistent’ part is that I create single method for each AJAX-call, named like the AJAX ID, prefixed with ‘AJAX_’, i.e. ‘AJAX_INIT’ for the ‘INIT’ AJAX call.
- The ‘dynamic’ part is that at runtime I have the HANDLE_ON_AJAX method call this method based on the supplied AJAX ID.
- To be able to access the parameters to the HANDLE_ON_AJAX method also in the separate AJAX_-methods, these are placed in a private attribute.

## How to use
Create one method for each AJAX call your app need. Inside this method you are able to access the parameters to the HANDLE_ON_AJAX method (like AJAX_VALUE for instance) in the handle_on_ajax_parametes global attribute. As long as there is a method named according to the convention of AJAX_ + the AJAX_ID, it will be called.

The AJAX-methods should contain all the code for the specific AJAX call, preferably factored by method calls. If there is code that is valid for every single AJAX-method, like logging, authorization checks, exception handling, etc, this still has its place before and/or after the TRY/CATCH block in the HANDLE_ON_AJAX method.

In the example above, if an AJAX call is made that does not have a corresponding AJAX method, the HANDLE_ON_AJAX method simply returns much like a CASE statement with no matching branch. If you need error handling for that scenario, call that code in the CATCH cx_sy_dyn_call_error block.

## Notes
Using this type of dynamic calling of the methods will have the effect that these calls will NOT be found by the Where-Used function in SAP. Please consider if this is an issue for you.

From a security perspective using dynamic method calls might constitute a security risk. By prefixing these method name with AJAX_, I consider this risk minimized and will not consider more of a threat than the already existing possiblity of making AJAX calls from a browser.