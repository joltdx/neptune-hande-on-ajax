CLASS zcl_neptune_handle_on_ajax DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC.

  PUBLIC SECTION.
    INTERFACES /neptune/if_nad_server.

  PROTECTED SECTION.
  PRIVATE SECTION.
    DATA:
      BEGIN OF handle_on_ajax_parameters,
        applid     TYPE string,
        ajax_id    TYPE string,
        ajax_value TYPE string,
        server     TYPE REF TO /neptune/cl_nad_server,
        request    TYPE /neptune/data_request,
        return     TYPE /neptune/ajax_return,
        navigation TYPE /neptune/ajax_navigation,
      END OF handle_on_ajax_parameters.

    METHODS ajax_init.
    METHODS ajax_prioritize.
    METHODS ajax_execute.

ENDCLASS.

CLASS zcl_neptune_handle_on_ajax IMPLEMENTATION.

  METHOD /neptune/if_nad_server~handle_on_ajax.

    handle_on_ajax_parameters = VALUE #( applid     = applid
                                         ajax_id    = ajax_id
                                         ajax_value = ajax_value
                                         server     = server
                                         request    = request
                                         return     = return
                                         navigation = navigation ).

    DATA(lv_ajax_method_name) = CONV seoclsname( |AJAX_{ ajax_id CASE = UPPER }| ).
    TRY.
        CALL METHOD (lv_ajax_method_name).
      CATCH cx_sy_dyn_call_error.
        RETURN.
    ENDTRY.

    return = handle_on_ajax_parameters-return.
    navigation = handle_on_ajax_parameters-navigation.

  ENDMETHOD.

  METHOD ajax_execute.
    " Code for an EXECUTE AJAX-call
  ENDMETHOD.

  METHOD ajax_init.
    " Code for an INIT AJAX-call
  ENDMETHOD.

  METHOD ajax_prioritize.
    " Code for a PRIORITIZE AJAX-call
  ENDMETHOD.
ENDCLASS.