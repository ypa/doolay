from django.shortcuts import render

from doolay.contacts.forms import ContactForm
from django.core.mail import EmailMessage
from django.shortcuts import redirect
from django.template import Context
from django.template.loader import get_template
from django.conf import settings


def contact(request):
    form_class = ContactForm

    if request.method == 'POST':
            form = form_class(data=request.POST)

            if form.is_valid():
                contact_name = request.POST.get(
                    'contact_name'
                , '')
                contact_email = request.POST.get(
                    'contact_email'
                , '')
                form_content = request.POST.get('content', '')

                # Email the profile with the 
                # contact information
                template = get_template('email_template.txt')
                context = Context({
                    'contact_name': contact_name,
                    'contact_email': contact_email,
                    'form_content': form_content,
                })
                content = template.render(context)

                email = EmailMessage(
                    subject="Inquiry from %s" % contact_email,
                    body=content,
                    from_email=contact_email,
                    to=[settings.DEFAULT_TO_EMAIL],
                    headers={'Reply-To': contact_email},
                    cc=(settings.DEFAULT_TO_EMAIL,)
                )

                email.send()
                return redirect('contact')

    return render(request, 'contacts.html', {
        'form': form_class,
    })
