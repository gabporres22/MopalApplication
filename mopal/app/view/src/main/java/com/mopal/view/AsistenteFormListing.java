package com.mopal.view;


import com.mopal.model.*;
import org.jetbrains.annotations.NotNull;
import tekgenesis.common.collections.ImmutableList;
import tekgenesis.common.core.Option;
import tekgenesis.form.Action;
import tekgenesis.form.MappingCallback;
import tekgenesis.persistence.Criteria;

import static com.mopal.core.NivelHelper.getNivelNinguno;
import static com.mopal.model.g.AsistenteBase.listWhere;
import static com.mopal.model.g.AsistenteTable.ASISTENTE;
import static tekgenesis.common.core.DateOnly.current;
import static tekgenesis.common.core.Option.option;

/** User class for form: AsistenteFormListing */
public class AsistenteFormListing extends AsistenteFormListingBase {
    @Override @NotNull public Action buscar() {
        getAsistentes().clear();

        final ImmutableList<Asistente> result = obtenerAsistentesFiltro(option(getNombreFiltro()), option(getApellidoFiltro()), option(getLocalidadFiltro()), option(getNivelFiltro()), option(getComunidadFiltro()));
        result.forEach(
            asistente -> getAsistentes().add().populate(asistente)
        );

        setTotalRows(String.valueOf(result.getSize().getOrFail("0")));

        return actions.getDefault();
    }

    private ImmutableList<Asistente> obtenerAsistentesFiltro(final Option<String> nombre, final Option<String> apellido, final Option<Localidad> localidad, final Option<Nivel> nivel, final Option<Comunidad> comunidad) {
        final Criteria nombreCriteria = nombre.isPresent() ? ASISTENTE.NOMBRE.contains(nombre.get()) : Criteria.EMPTY;
        final Criteria apellidoCriteria = apellido.isPresent() ? ASISTENTE.APELLIDO.contains(apellido.get()) : Criteria.EMPTY;
        final Criteria localidadCriteria = localidad.isPresent() ? ASISTENTE.LOCALIDAD_ID.eq(localidad.get().getId()) : Criteria.EMPTY;
        final Criteria nivelCriteria = nivel.isPresent() ? ASISTENTE.NIVEL_ID.eq(nivel.get().getId()) : Criteria.EMPTY;
        final Criteria comunidadCriteria = comunidad.isPresent() && nivel.isPresent() && !nivel.get().equals(getNivelNinguno()) ? ASISTENTE.COMUNIDAD_ID.eq(comunidad.get().getId()) : Criteria.EMPTY;

        return listWhere(nombreCriteria.and(apellidoCriteria.and(localidadCriteria.and(nivelCriteria).and(comunidadCriteria))))
                .orderBy(ASISTENTE.APELLIDO, ASISTENTE.NOMBRE)
                .toList();
    }

    @NotNull
    @Override
    public Action resetearFiltros() {
        getAsistentes().clear();
        loadAsistentes();
        return actions.getStay();
    }

    @NotNull
    @Override
    public Action addAsistente() {
        return actions().navigate(AsistenteForm.class).callback(AsistenteFormMapping.class);
    }

    private Boolean isFilterPresent() {
        return option(getNombreFiltro()).isPresent() || option(getApellidoFiltro()).isPresent() || option(getLocalidadFiltro()).isPresent() || option(getNivelFiltro()).isPresent()|| option(getComunidadFiltro()).isPresent();
    }

    public class AsistentesRow extends AsistentesRowBase {
        @Override
        public void populate(@NotNull Asistente asistente) {
            super.populate(asistente);
            setEdad(String.valueOf(current().yearsFrom(asistente.getFechaNacimiento())) + " años");
        }

        @NotNull
        @Override
        public Action editarPersona() {
            return actions().navigate(AsistenteForm.class, String.valueOf(getId())).callback(AsistenteFormMapping.class);
        }
    }

    public static class AsistenteFormMapping implements MappingCallback<AsistenteForm, AsistenteFormListing> {
        @Override
        public void onDelete(@NotNull AsistenteForm base, @NotNull AsistenteFormListing out) {
            search(out);
        }

        @Override
        public void onSave(@NotNull AsistenteForm base, @NotNull AsistenteFormListing out) {
            search(out);
        }

        private void search(final AsistenteFormListing out) {
            if(out.isFilterPresent()){
                out.buscar();
            } else {
                out.getAsistentes().clear();
                out.loadAsistentes();
            }
        }
    }
}
