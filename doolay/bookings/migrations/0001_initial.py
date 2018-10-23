# -*- coding: utf-8 -*-
# Generated by Django 1.11.13 on 2018-06-03 13:19
from __future__ import unicode_literals

from django.db import migrations, models
import django.db.models.deletion
import eventtools.models


class Migration(migrations.Migration):

    initial = True

    dependencies = [
        ('experiences', '0005_auto_20170615_0435'),
    ]

    operations = [
        migrations.CreateModel(
            name='Booking',
            fields=[
                ('experience_page', models.OneToOneField(on_delete=django.db.models.deletion.CASCADE, primary_key=True, serialize=False, to='experiences.ExperiencePage')),
            ],
            options={
                'abstract': False,
            },
            bases=(models.Model, eventtools.models.OccurrenceMixin),
        ),
        migrations.CreateModel(
            name='BookingSlot',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('start', models.DateTimeField(db_index=True)),
                ('end', models.DateTimeField(blank=True, db_index=True, null=True)),
                ('repeat', eventtools.models.ChoiceTextField(blank=True, choices=[('RRULE:FREQ=DAILY', 'Daily'), ('RRULE:FREQ=WEEKLY', 'Weekly'), ('RRULE:FREQ=MONTHLY', 'Monthly'), ('RRULE:FREQ=YEARLY', 'Yearly')], default='')),
                ('repeat_until', models.DateField(blank=True, null=True)),
                ('booking', models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name='booking_slots', related_query_name='booking_slot', to='bookings.Booking')),
            ],
            options={
                'ordering': ('start', 'end'),
                'abstract': False,
            },
            bases=(models.Model, eventtools.models.OccurrenceMixin),
        ),
    ]
