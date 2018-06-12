package com.mopal.view;


import org.jetbrains.annotations.NotNull;
import tekgenesis.form.Action;
import tekgenesis.form.MappingCallback;

/** User class for form: EventoListing */
public class EventoListing extends EventoListingBase {

    @NotNull
    @Override
    public Action saveEvento() {
        if (getEventos().filter(item -> item.isActivo()).size() > 1) {
            getEventos().clear();
            loadEventos();
            return actions().getDefault().withMessage("No puede haber más de un evento activo.");
        }

        return super.saveEvento();
    }

    @NotNull
    @Override
    public Action createEvento() {
        return actions().navigate(EventoForm.class).callback(EventoCallback.class);
    }

    //~ Inner Classes ............................................................................................................
    public class EventosRow extends EventosRowBase {

    }

    public static class EventoCallback implements MappingCallback<EventoForm, EventoListing> {
        @Override
        public void onSave(@NotNull EventoForm base, @NotNull EventoListing out) {
            out.getEventos().clear();
            out.loadEventos();
        }
    }
}
