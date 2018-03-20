package com.mopal.services;

import com.mopal.model.Persona;
import tekgenesis.common.collections.Seq;
import tekgenesis.service.Factory;
import org.jetbrains.annotations.NotNull;
import tekgenesis.service.Result;

/** User class for Handler: PersonaService */
public class PersonaService
    extends PersonaServiceBase
{

    //~ Constructors .............................................................................................................

    PersonaService(@NotNull Factory factory) { super(factory); }

    //~ Methods ..................................................................................................................

    /** Invoked for route "/api/persona/all" */
    @Override @NotNull public Result<Seq<Persona>> list() { return notImplemented(); }

}
