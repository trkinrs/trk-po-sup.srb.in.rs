---
layout: page
title: Oglasi
permalink: /oglasi/
---

Ovde možete naći oglase vezane za kupoprodaju veslačke opreme.

Za izdavanje opreme može se koristiti [obrazac ugovora za izdavanje SUP daske]({{ site.baseurl }}/ugovor-o-izdavanju-sup-daske/).

{% assign active_ads = site.ads | where: "sold", false %}
{% assign sold_ads = site.ads | where: "sold", true %}

{% if site.ads.size == 0 %}
  *Trenutno nema aktivnih oglasa.*
{% else %}

## Aktivni oglasi

{% if active_ads.size == 0 %}
*Nema aktivnih oglasa.*
{% else %}
<div class="posts">
{% for ad in active_ads %}
  <div class="post">
    <div class="post-list-item">
      {% if ad.image %}
        {% assign ad_thumb_src = ad.image %}
        {% unless ad_thumb_src contains '://' %}
          {% assign ad_thumb_src = ad_thumb_src | relative_url %}
        {% endunless %}
        <div class="post-list-aside">
          <a href="{{ ad.url | relative_url }}" class="post-thumb-link" aria-label="{{ ad.title | escape }}">
            <img class="post-thumb" src="{{ ad_thumb_src }}" alt="" loading="lazy">
          </a>
        </div>
      {% endif %}

      <div class="post-list-body">
        <a href="{{ ad.url | relative_url }}" class="post-link">
          <h3 class="post-title">{{ ad.title }}</h3>
        </a>
        <p class="post-summary">
          {% if ad.price %}<strong>{{ ad.price }}</strong> &mdash; {% endif %}
          {% if ad.location %}📍 {{ ad.location }} &mdash; {% endif %}
          {{ ad.summary }}
        </p>
        <a href="{{ ad.url | relative_url }}">Pogledaj oglas &rarr;</a>
      </div>
    </div>
  </div>
{% endfor %}
</div>
{% endif %}

{% if sold_ads.size > 0 %}
## Prodato

<div class="posts">
{% for ad in sold_ads %}
  <div class="post" style="opacity:0.55;">
    <div class="post-list-item">
      {% if ad.image %}
        {% assign ad_thumb_src = ad.image %}
        {% unless ad_thumb_src contains '://' %}
          {% assign ad_thumb_src = ad_thumb_src | relative_url %}
        {% endunless %}
        <div class="post-list-aside">
          <a href="{{ ad.url | relative_url }}" class="post-thumb-link" aria-label="{{ ad.title | escape }}">
            <img class="post-thumb" src="{{ ad_thumb_src }}" alt="" loading="lazy">
          </a>
        </div>
      {% endif %}

      <div class="post-list-body">
        <h3 class="post-title" style="text-decoration:line-through;">{{ ad.title }}</h3>
        <p class="post-summary post-meta">PRODATO &mdash; {{ ad.summary }}</p>
      </div>
    </div>
  </div>
{% endfor %}
</div>
{% endif %}

{% endif %}
