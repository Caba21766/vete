from django.http import Http404
from django.shortcuts import get_object_or_404, render, redirect
from django.urls import reverse_lazy
from django.views.generic import FormView, UpdateView
from django.contrib.auth.views import LoginView
from django.contrib.auth.models import User
from django.contrib.auth.mixins import LoginRequiredMixin
from django.contrib import messages
from django.contrib.auth.decorators import login_required
from .forms import RegistrarseForm, EditarUsuarioForm


#---------------------------------------------------------------------------#
class RegistrarseView(FormView):
    template_name = 'users/registrarse.html'
    form_class = RegistrarseForm
    success_url = reverse_lazy('index')

    def form_valid(self, form):
        user = form.save(commit=False)
        user.dni_usuario = form.cleaned_data['dni_usuario']
        user.domicilio_usuario = form.cleaned_data['domicilio_usuario']
        user.tel1_usuario = form.cleaned_data['tel1_usuario']
        user.tel2_usuario = form.cleaned_data.get('tel2_usuario')
        user.imagen_usuario = form.cleaned_data.get('imagen_usuario')
        user.save()
        messages.success(self.request, "Tu cuenta ha sido creada exitosamente.")
        return super().form_valid(form)

#---------------------------------------------------------------------------#
from .forms import CustomLoginForm
class IniciarSesionView(LoginView):
    template_name = 'users/iniciar_sesion.html'
    authentication_form = CustomLoginForm

#---------------------------------------------------------------------------#

class EditarPerfil(LoginRequiredMixin, UpdateView):
    model = User
    form_class = RegistrarseForm
    template_name = 'users/registrarse.html'
    success_url = reverse_lazy('index')

    def get_object(self, queryset=None):
        return get_object_or_404(User, pk=self.request.user.pk)

    def dispatch(self, request, *args, **kwargs):
        user_id = self.kwargs.get('pk')
        if str(user_id) != str(request.user.pk):
            raise Http404("No tienes permiso para editar este perfil.")
        return super().dispatch(request, *args, **kwargs)

    def form_valid(self, form):
        form.save()
        messages.success(self.request, "Perfil actualizado correctamente.")
        return super().form_valid(form)

#---------------------------------------------------------------------------#

def perfil_view(request):
    return render(request, 'users/perfil.html', {'user': request.user})

#---------------------------------------------------------------------------#

def pedir_con_view(request):
    return render(request, 'users/pedir_con.html')

#---------------------------------------------------------------------------#

@login_required
def editar_usuario(request, pk):
    usuario = get_object_or_404(User, pk=pk)
    if request.method == 'POST':
        form = EditarUsuarioForm(request.POST, request.FILES, instance=usuario)
        if form.is_valid():
            form.save()
            return redirect('apps.blog_auth:perfil')
    else:
        form = EditarUsuarioForm(instance=usuario)
    return render(request, 'users/editar_usuario.html', {'form': form})

#---------------------------------------------------------------------------#
from django.shortcuts import render
from django.contrib.auth.models import User

def lista_usuarios(request):
    usuarios = User.objects.all()
    return render(request, 'users/lista_usuarios.html', {'usuarios': usuarios})

#---------------------------------------------------------------------------#
from django.views.generic import TemplateView  # Importa TemplateView correctamente
class TuVista(TemplateView):
    template_name = 'tu_template.html'

    def get_context_data(self, **kwargs):
        context = super().get_context_data(**kwargs)
        context['user'] = self.request.user
        return context

#---------------------------------------------------------------------------#

class EditarUsuarioView(UpdateView):
    model = User
    form_class = EditarUsuarioForm
    template_name = 'users/editar_usuario.html'
    success_url = '/'

    def get_object(self, queryset=None):
        return User.objects.get(pk=self.kwargs['pk'])
