package com.mopal.view;

import com.mopal.model.*;
import tekgenesis.common.collections.ImmutableList;
import tekgenesis.common.core.Option;
import tekgenesis.form.Action;
import org.jetbrains.annotations.NotNull;
import tekgenesis.form.MappingCallback;
import tekgenesis.persistence.Criteria;

import java.math.BigDecimal;

import static com.mopal.core.NivelHelper.getNivelNinguno;
import static com.mopal.model.TipoEvento.RETIRO_DE_PASCUA;
import static com.mopal.model.g.AsistenteRetiroPascuaBase.find;
import static com.mopal.model.g.AsistenteRetiroPascuaBase.listWhere;
import static com.mopal.model.g.AsistenteRetiroPascuaTable.ASISTENTE_RETIRO_PASCUA;
import static com.mopal.model.g.AsistenteTable.ASISTENTE;
import static com.mopal.model.g.EventoBase.findWhere;
import static com.mopal.model.g.EventoTable.EVENTO;
import static tekgenesis.common.core.DateOnly.current;
import static tekgenesis.common.core.Option.option;

/** User class for form: AsistenteRetiroDePascuaFormListing */
public class AsistenteRetiroDePascuaFormListing extends AsistenteRetiroDePascuaFormListingBase {
    final Evento evento = findWhere(EVENTO.ACTIVO.eq(true).and(EVENTO.TIPO_EVENTO.eq(RETIRO_DE_PASCUA)));

    //~ Methods ..................................................................................................................

    private Evento getEvento() {
        return evento;
    }

    public void buscar(final Integer idEvento, final Integer idAsistente) {
        getAsistentesRetiroPascua().clear();
        getAsistentesRetiroPascua().add().populate(find(idEvento, idAsistente));
        setTotalRows("");
    }

    private Boolean isFilterPresent() {
        return option(getNombreFiltro()).isPresent() || option(getApellidoFiltro()).isPresent() || option(getLocalidadFiltro()).isPresent() || option(getNivelFiltro()).isPresent()|| option(getComunidadFiltro()).isPresent();
    }

    private ImmutableList<AsistenteRetiroPascua> obtenerAsistentesFiltro(final Option<String> nombre, final Option<String> apellido, final Option<Localidad> localidad, final Option<Nivel> nivel, final Option<Comunidad> comunidad) {
        final Criteria eventoCriteria = EVENTO.ID.eq(getEvento().getId());
        final Criteria nombreCriteria = nombre.isPresent() ? ASISTENTE.NOMBRE.contains(nombre.get()) : Criteria.EMPTY;
        final Criteria apellidoCriteria = apellido.isPresent() ? ASISTENTE.APELLIDO.contains(apellido.get()) : Criteria.EMPTY;
        final Criteria localidadCriteria = localidad.isPresent() ? ASISTENTE.LOCALIDAD_ID.eq(localidad.get().getId()) : Criteria.EMPTY;
        final Criteria nivelCriteria = nivel.isPresent() ? ASISTENTE.NIVEL_ID.eq(nivel.get().getId()) : Criteria.EMPTY;
        final Criteria comunidadCriteria = comunidad.isPresent() && nivel.isPresent() && !nivel.get().equals(getNivelNinguno()) ? ASISTENTE.COMUNIDAD_ID.eq(comunidad.get().getId()) : Criteria.EMPTY;

        return listWhere(eventoCriteria.and(nombreCriteria.and(apellidoCriteria.and(localidadCriteria.and(nivelCriteria).and(comunidadCriteria)))))
                .join(EVENTO, ASISTENTE_RETIRO_PASCUA.EVENTO_ID.eq(EVENTO.ID))
                .join(ASISTENTE, ASISTENTE_RETIRO_PASCUA.PERSONA_ID.eq(ASISTENTE.ID))
                .orderBy(ASISTENTE.APELLIDO, ASISTENTE.NOMBRE)
                .toList();
    }

    @Override
    public void load() {
        super.load();
        setDescripcionEvento(getEvento().getDescripcion());
    }

    /** Invoked when button(buscar) is clicked */
    @Override @NotNull public Action buscar() {
        getAsistentesRetiroPascua().clear();

        final ImmutableList<AsistenteRetiroPascua> result = obtenerAsistentesFiltro(option(getNombreFiltro()), option(getApellidoFiltro()), option(getLocalidadFiltro()), option(getNivelFiltro()), option(getComunidadFiltro()));
        result.forEach(
                persona -> getAsistentesRetiroPascua().add().populate(persona)
        );

        setTotalRows(String.valueOf(result.getSize().getOrFail("0")));

        return actions.getDefault();
    }

    /** Invoked when button(resetear) is clicked */
    @Override @NotNull public Action resetearFiltros() {
        getAsistentesRetiroPascua().clear();
        loadAsistentes();
        return actions.getStay();
    }
    /** Invoked when button(create) is clicked */
    @Override @NotNull public Action addAsistencia() {
        final AsistenteRetiroPascuaForm form = forms.initialize(AsistenteRetiroPascuaForm.class);
        form.setEvento(getEvento());
        form.setForCreation(true);
        return actions().navigate(form).callback(AsistenciaFormMapping.class); }

    @Override
    public void loadAsistentes() {
        buscar();
    }

    //~ Inner Classes ............................................................................................................

    public class AsistentesRetiroPascuaRow extends AsistentesRetiroPascuaRowBase {

        //~ Methods ..................................................................................................................

        @Override
        public void populate(@NotNull AsistenteRetiroPascua asistenteRetiroPascua) {
            super.populate(asistenteRetiroPascua);
            setIdEvento(asistenteRetiroPascua.getEvento().getId());
            setIdPersona(asistenteRetiroPascua.getPersona().getId());
            setNombre(asistenteRetiroPascua.getPersona().getNombre());
            setApellido(asistenteRetiroPascua.getPersona().getApellido());
            setEdad(String.valueOf(current().yearsFrom(asistenteRetiroPascua.getPersona().getFechaNacimiento())) + " años");
            setNivel(asistenteRetiroPascua.getPersona().getNivel());
            setComunidad(asistenteRetiroPascua.getPersona().getComunidad());
            setTelefono(asistenteRetiroPascua.getPersona().getTelefonoDeContacto());
            setContribucion(asistenteRetiroPascua.getMontoContribucion().compareTo(BigDecimal.ZERO) > 0);
            setPersonasACargo(asistenteRetiroPascua.getPersonasRelacionadas().size());
        }

        @NotNull
        @Override
        public Action editarPersona() {
            final AsistentesRetiroPascuaRow current = getAsistentesRetiroPascua().getCurrent();
            return actions().navigate(AsistenteRetiroPascuaForm.class, String.valueOf(current.getIdPersona())).callback(PersonaFormMapping.class);

        }

        @NotNull
        @Override
        public Action editarAsistencia() {
            final AsistentesRetiroPascuaRow current = getAsistentesRetiroPascua().getCurrent();
            final AsistenteRetiroPascua asistenteRetiroPascua = find(getEvento().getId(), current.getIdPersona());
            return actions().navigate(AsistenteRetiroPascuaForm.class, asistenteRetiroPascua.keyAsString()).callback(AsistenciaFormMapping.class);
        }

    }

    public static class PersonaFormMapping implements MappingCallback<AsistenteRetiroPascuaForm, AsistenteRetiroDePascuaFormListing> {
        @Override
        public void onSave(@NotNull AsistenteRetiroPascuaForm base, @NotNull AsistenteRetiroDePascuaFormListing out) {
            if(out.isFilterPresent()){
                out.buscar();
            } else {
                out.getAsistentesRetiroPascua().clear();
                out.loadAsistentes();
            }
        }
    }

    public static class AsistenciaFormMapping implements MappingCallback<AsistenteRetiroPascuaForm, AsistenteRetiroDePascuaFormListing> {
        @Override
        public void onDelete(@NotNull AsistenteRetiroPascuaForm base, @NotNull AsistenteRetiroDePascuaFormListing out) {
            search(out);
        }

        @Override
        public void onSave(@NotNull AsistenteRetiroPascuaForm base, @NotNull AsistenteRetiroDePascuaFormListing out) {
            if(base.isForCreation()) {
                out.buscar(base.getEvento().getId(), base.getPersona().getId());
            } else {
                search(out);
            }
        }

        private void search(final AsistenteRetiroDePascuaFormListing out) {
            if(out.isFilterPresent()){
                out.buscar();
            } else {
                out.getAsistentesRetiroPascua().clear();
                out.loadAsistentes();
            }
        }
    }
}
