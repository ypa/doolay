from django.shortcuts import render
from django.http import HttpResponseRedirect
from django.contrib import messages

from doolay.contacts.forms import ContactForm
from django.core.mail import EmailMultiAlternatives
from django.shortcuts import redirect
from django.template.loader import get_template
from django.conf import settings


def contact(request):
    form_class = ContactForm

    if request.method == 'POST':
        form = form_class(data=request.POST)

        if form.is_valid():
            contact_name = request.POST.get('contact_name', '')
            contact_email = request.POST.get('contact_email', '')
            form_content = request.POST.get('content', '')

            # Email the profile with the
            # contact information
            text_template = get_template('email_template.txt')
            html_template = get_template('email_template.html')
            context = {
                'contact_name': contact_name,
                'contact_email': contact_email,
                'form_content': form_content,
            }
            text_content = text_template.render(context)
            html_content = html_template.render(context)

            email = EmailMultiAlternatives(
                subject="Inquiry from %s" % contact_email,
                body=text_content,
                from_email=contact_email,
                to=[settings.DEFAULT_TO_EMAIL],
                headers={'Reply-To': contact_email},
                cc=(settings.DEFAULT_TO_EMAIL, ))
            email.attach_alternative(html_content, 'text/html')

            email.send()
            messages.success(request, 'Your inquiry was sent successfully!')
            redirect_url = request.META.get('HTTP_REFERER', '/')
            return HttpResponseRedirect(redirect_url)

    return render(request, 'contacts.html', {
        'form': form_class,
    })
