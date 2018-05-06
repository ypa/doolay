# -*- coding: utf-8 -*-
# Generated by Django 1.9.9 on 2017-04-15 03:10
from __future__ import unicode_literals

from django.db import migrations, models
import django.db.models.deletion
import wagtail.core.blocks
import wagtail.core.fields
import wagtail.embeds.blocks
import wagtail.images.blocks


class Migration(migrations.Migration):

    initial = True

    dependencies = [
        ('wagtailimages', '0016_deprecate_rendition_filter_relation'),
        ('wagtailcore', '0032_add_bulk_delete_page_permission'),
    ]

    operations = [
        migrations.CreateModel(
            name='ExperienceIndexPage',
            fields=[
                ('page_ptr', models.OneToOneField(auto_created=True, on_delete=django.db.models.deletion.CASCADE, parent_link=True, primary_key=True, serialize=False, to='wagtailcore.Page')),
                ('introduction', models.TextField(blank=True, help_text='Text to describe the index page')),
                ('image', models.ForeignKey(blank=True, help_text='Experiences listing image', null=True, on_delete=django.db.models.deletion.SET_NULL, related_name='+', to='wagtailimages.Image')),
            ],
            options={
                'abstract': False,
            },
            bases=('wagtailcore.page',),
        ),
        migrations.CreateModel(
            name='ExperiencePage',
            fields=[
                ('page_ptr', models.OneToOneField(auto_created=True, on_delete=django.db.models.deletion.CASCADE, parent_link=True, primary_key=True, serialize=False, to='wagtailcore.Page')),
                ('body', wagtail.core.fields.StreamField((('paragraph', wagtail.core.blocks.RichTextBlock(icon='pilcrow', template='blocks/paragraph.html')), ('header', wagtail.core.blocks.StructBlock((('header_text', wagtail.core.blocks.CharBlock(blank=True, label='Header', required=False)), ('size', wagtail.core.blocks.ChoiceBlock(blank=True, choices=[('', 'Select a header size'), ('h2', 'H2'), ('h3', 'H3'), ('h4', 'H4')], required=False))), classname='title', icon='title', template='blocks/header.html')), ('image', wagtail.core.blocks.StructBlock((('image', wagtail.images.blocks.ImageChooserBlock()), ('caption', wagtail.core.blocks.CharBlock(blank=True, required=False)), ('style', wagtail.core.blocks.ChoiceBlock(choices=[('', 'Select an image size'), ('full', 'Full-width'), ('contain', 'Contained-width'), ('half', 'Half-width')], required=False))), icon='image', template='blocks/image.html')), ('blockquote', wagtail.core.blocks.StructBlock((('text', wagtail.core.blocks.TextBlock()), ('attribute_name', wagtail.core.blocks.CharBlock(blank=True, label='e.g. Guy Picciotto', required=False)), ('attribute_group', wagtail.core.blocks.CharBlock(blank=True, label='e.g. Fugazi', required=False))), icon='openquote', template='blocks/blockquote.html')), ('embed', wagtail.embeds.blocks.EmbedBlock(help_text='Insert an embed URL e.g https://www.youtube.com/embed/SGJFWirQ3ks'))), blank=True, verbose_name='A description of this experience')),
                ('image', models.ForeignKey(blank=True, help_text='Experiences image', null=True, on_delete=django.db.models.deletion.SET_NULL, related_name='+', to='wagtailimages.Image')),
            ],
            options={
                'abstract': False,
            },
            bases=('wagtailcore.page',),
        ),
    ]
