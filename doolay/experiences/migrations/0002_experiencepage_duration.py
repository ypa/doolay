# -*- coding: utf-8 -*-
# Generated by Django 1.9.9 on 2017-05-02 02:52
from __future__ import unicode_literals

import datetime
from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('experiences', '0001_initial'),
    ]

    operations = [
        migrations.AddField(
            model_name='experiencepage',
            name='duration',
            field=models.DurationField(default=datetime.timedelta),
        ),
    ]
