package com.mopal.view;

import tekgenesis.service.Factory;
import tekgenesis.service.html.Html;
import org.jetbrains.annotations.NotNull;
import tekgenesis.service.Result;

/** User class for Handler: HtmlSecuredHandler */
public class HtmlSecuredHandler extends HtmlSecuredHandlerBase {
    private final Views v;

    //~ Constructors .............................................................................................................

    HtmlSecuredHandler(@NotNull Factory factory) {
        super(factory);
        v = factory.html(Views.class);
    }

    //~ Methods ..................................................................................................................

    /** Invoked for route "/" */
    @Override @NotNull public Result<Html> home() { return ok(v.home()); }

}
