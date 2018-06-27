package com.mopal.services;

import com.mopal.model.Asistente;
import tekgenesis.common.collections.Seq;
import tekgenesis.service.Factory;
import org.jetbrains.annotations.NotNull;
import tekgenesis.service.Result;

/** User class for Handler: AsistenteService */
public class AsistenteService
    extends AsistenteServiceBase
{

    //~ Constructors .............................................................................................................

    AsistenteService(@NotNull Factory factory) { super(factory); }

    //~ Methods ..................................................................................................................

    /** Invoked for route "/api/asistente/all" */
    @Override @NotNull public Result<Seq<Asistente>> list() { return notImplemented(); }

}
