# -*- coding: utf-8 -*-
# Generated by Django 1.9.9 on 2017-05-09 03:49
from __future__ import unicode_literals

from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    dependencies = [
        ('hosts', '0004_auto_20170509_0449'),
        ('experiences', '0002_experiencepage_duration'),
    ]

    operations = [
        migrations.AddField(
            model_name='experiencepage',
            name='host',
            field=models.ForeignKey(null=True, on_delete=django.db.models.deletion.SET_NULL, related_name='providing_experiences', to='hosts.HostPage'),
        ),
    ]
