package com.mopal.view;

import com.mopal.model.Asistente;
import com.mopal.model.Barrio;
import com.mopal.model.Comunidad;
import tekgenesis.form.Action;
import org.jetbrains.annotations.NotNull;
import org.jetbrains.annotations.Nullable;
import tekgenesis.form.MappingCallback;

import static tekgenesis.common.core.DateOnly.current;

/** User class for widget: AsistenteWidget */
public class AsistenteWidget extends AsistenteWidgetBase {

    //~ Methods ..................................................................................................................
    @NotNull
    @Override
    public Action updateEdad() {
        actualizarEdad();
        return actions().getDefault();
    }

    private void actualizarEdad() {
        setEdadValue(String.valueOf(current().yearsFrom(getFechaNacimiento())) + " años");
    }

    @Override
    public void populate(@NotNull Asistente asistente) {
        super.populate(asistente);
        actualizarEdad();
    }
}
