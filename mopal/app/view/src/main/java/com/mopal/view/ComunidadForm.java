package com.mopal.view;


import com.mopal.model.Barrio;
import org.jetbrains.annotations.NotNull;
import org.jetbrains.annotations.Nullable;
import tekgenesis.form.Action;
import tekgenesis.form.MappingCallback;

/** User class for form: ComunidadForm */
public class ComunidadForm extends ComunidadFormBase {

    @NotNull
    @Override
    public Action createBarrio(@Nullable String text) {
        final BarrioForm newForm = forms.initialize(BarrioForm.class);

        newForm.setDisableLocalidad(true);
        newForm.setLocalidad(getLocalidad());

        return actions().navigate(newForm).callback(BarrioFormMapping.class);
    }

    public static class BarrioFormMapping implements MappingCallback<BarrioForm, ComunidadForm> {
        @Override
        public void onSave(@NotNull BarrioForm base, @NotNull ComunidadForm out) {
            final Barrio barrio = Barrio.find(base.getId());
            out.setBarrio(barrio);
        }
    }
}
