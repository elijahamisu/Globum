# Globum design system: "Emerald & Chrome"

Luxury dark theme taken straight from the Globum logo: a glowing emerald globe wrapped in a chrome-silver "G" swoosh on near-black. One stylesheet, `assets/css/top.css`, holds the system (the full class index is the comment at the top of that file); `top-app.css` (user app pages) and `top-admin.css` (admin panel) layer on top of it. These notes explain how to use it.

## Brand

| Asset | Use |
|---|---|
| `assets/img/logo.svg` | Logo mark + "Globum" wordmark in a chrome-silver gradient. Default everywhere (nav, rail, sidebars) since every background is dark |
| `assets/img/logo-white.svg` | The same with a flat white wordmark (footer) |
| `assets/img/logo-mark.svg` | Mark only (auth card header, loaders, app icon spots) |
| `assets/img/favicon.svg` | Favicon |
| `assets/img/globum-logo.jpg` | Full-resolution logo artwork, used as the glowing "orb" in the landing hero |

**Fonts:** *Playfair Display* (500/600 + italic) for display headings, *Manrope* (400–800) for UI, body text and every money figure (`--f-num`, tabular numerals). top.css `@import`s both and every page also preloads them with a `<link>`.

**Palette tokens**

| Group | Tokens |
|---|---|
| Surfaces | `--bg #050807` (page) · `--bg-2 #0A120D` (rails, sidebars) · `--surface #0F1A14` (cards) · `--surface-2 #13221A` · `--surface-3 #1A2E23` · `--tint` / `--tint-2` / `--tint-3` (translucent emerald washes) |
| Emerald | `--emerald #16A34A` · `--emerald-deep #0B6B3A` · `--emerald-dark #06341C` · `--emerald-bright #4ADE80` · `--accent #4ADE80` (green for text, icons and links on dark) · `--accent-hover #86EFAC` |
| Chrome | `--chrome-1 #F5F7F6` · `--chrome-2 #C9CED1` · `--chrome-3 #8B9399` · `--silver` (labels, table heads) |
| Ink | `--ink #F2F5F3` (body text, ~16:1 on surfaces) · `--ink-2 #A7B1AC` (secondary, ~8:1) · `--ink-3 #7C8782` (placeholders/icons only) |
| Lines | `--line` (silver hairline) · `--line-strong` (emerald hairline) · `--line-chrome` |
| Status | `--success #4ADE80` · `--warning`/`--amber #FBBF24` · `--danger #F87171` (+ `--danger-tint`). Red exists **only** for genuine errors, rejections, deletes and log-out |
| Gradients | `--grad-green` (primary buttons, active pills) · `--grad-chrome` (metal buttons, chips, headline text) · `--grad-chrome-x` (horizontal metallic hairline) · `--grad-card` (luxury bank-card background) · `--grad-surface` (card sheen) · `--globe-lines` (SVG meridian pattern) |
| Shadows | `--shadow-xs|sm|md|lg`, `--shadow-glow` (emerald), `--glow-hover` |

Old variable names are kept as aliases so older markup and script-written inline styles stay on-brand: `--red` → `--accent`, `--red-deep` → `--silver`, `--red-50/100/200` → `--tint*`, `--grad-red` → `--grad-green`, `--shadow-red` → `--shadow-glow`, plus `--accent-color`, `--text-muted`, `--success`, `--danger`, `--card-bg`, …

**Rules of thumb**
- Near-black page, glassy dark `.card`s with a thin silver hairline (and a chrome-to-emerald top highlight). Cards gain a soft emerald glow on hover.
- Reserve the luxury bank-card treatment (`.card-hero`, `.stat-card.is-hero`, `.plan-card.is-featured`) for the one or two things that matter most on a screen: balances, the featured plan, the key KPI. Add `<span class="card-chip"></span>` for the chrome EMV chip.
- Primary action = `.btn-primary` (emerald). Secondary = `.btn-outline` (chrome hairline). On hero cards use `.btn-white` (polished chrome metal, dark text) and `.btn-on-red` (glass outline).
- Headings: `.display`, `.h1`, `.h2`, `.page-title`, `.auth-head h1` and `.section-title h2` get the chrome gradient automatically. `<em>` inside a heading becomes an emerald italic accent.
- Money: wrap it in `.stat-value` / `.balance-amount` / `.plan-price` (Manrope 800, tabular numerals). The big balance is chrome-gradient text.
- Don't add one-off colours. Telegram buttons are `.btn-primary` / `.btn-outline`, not Telegram blue. Chart.js charts are painted `#4ADE80` (primary series) and `#C9CED1` (secondary) with `Chart.defaults.color = '#A7B1AC'`.

## Head template (every page)

```html
<link rel="icon" type="image/svg+xml" href="assets/img/favicon.svg">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Manrope:wght@400;500;600;700;800&family=Playfair+Display:ital,wght@0,500;0,600;0,700;1,500;1,600&display=swap" rel="stylesheet">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
<script src="https://cdn.jsdelivr.net/npm/@supabase/supabase-js@2"></script>   <!-- if the page used it -->
<link rel="stylesheet" href="assets/css/top.css">
<meta name="theme-color" content="#050807">
<style>/* only small page-specific rules, using the tokens */</style>
```
(Admin pages use `../assets/...`.)

## App page shell (user pages, step 2). Reference: `dashboard.html`

```html
<body class="app-body">
  <header class="app-header">
    <div class="container app-header-inner">
      <!-- dashboard: .user-chip with .avatar + .hello; other pages: -->
      <div class="row-between" style="gap:12px">
        <a href="dashboard.html" class="back-btn"><i class="fas fa-arrow-left"></i></a>
        <div><h1 class="page-title">Wallet</h1></div>
      </div>
      <div class="header-actions"><a class="icon-btn" href="notifications.html"><i class="fas fa-bell"></i></a></div>
    </div>
  </header>

  <main class="container app-main">          <!-- direct children get 24px rhythm -->
    <section class="card-hero"> … </section>  <!-- hero/balance: .balance-label .balance-amount .balance-split > .split-item -->
    <section class="grid grid-2c grid-4"> <div class="stat-card"><span class="stat-icon"><i class="fas fa-…"></i></span><h3 class="stat-value" id="…">0</h3><p class="stat-label">…</p></div> … </section>
    <section>
      <div class="section-head"><h3>Recent</h3><a class="view-all" href="…">See all</a></div>
      <div class="card"> … form or list … </div>
    </section>
  </main>

  <nav class="bottom-nav">                    <!-- fixed bottom bar on phones; left rail >= 960px -->
    <a href="dashboard.html" class="rail-brand"><img src="assets/img/logo.svg" alt="Globum"></a>
    <a href="dashboard.html" class="nav-item active"><i class="fas fa-th-large"></i><span>Home</span></a>
    <a href="plans.html" class="nav-item"><i class="fas fa-layer-group"></i><span>Plans</span></a>
    <a href="wallet.html" class="nav-item"><i class="fas fa-wallet"></i><span>Wallet</span></a>
    <a href="notifications.html" class="nav-item"><i class="fas fa-bell"></i><span>Alerts</span></a>
    <a href="profile.html" class="nav-item"><i class="fas fa-user-circle"></i><span>Profile</span></a>
  </nav>
</body>
```
- `.split-2` puts two blocks side by side (7/5) from 1100px. `.grid-2c` stays 2 columns even on phones. `.grid-2/3/4` stack to 1 column on phones.
- Rows (transactions, investments, notifications): `.list-item` with `.li-icon`, `.li-body > .li-title + .li-sub`, `.li-end`. JS that renders `.investment-card / .inv-info / .inv-badge` is already styled the same way.
- Quick actions: `.quick-actions > a.action-item > .action-icon + span` (5 columns), ideally inside a `.card`.

## Components cheat-sheet
- **Buttons:** `.btn` + `.btn-primary` (emerald gradient) | `.btn-outline` (chrome hairline) | `.btn-ghost` | `.btn-white` (chrome metal, for hero cards) | `.btn-on-red` (glass outline on hero cards) | `.btn-dark`. Sizes: `.btn-sm`, `.btn-lg`. Use `.btn-block` for full width. For a loading state, put `.spinner` inside the button; JS toggles its `display`. Square icon button: `.icon-btn` (use `.icon-btn-red` for the filled version).
- **Forms:** `.form-group > label + .input-wrapper > i + input.form-control`. `.form-grid` gives 2 columns from 640px, with `.full-width` spanning both. Add `.form-hint` / `.form-error` under a field. `select.form-control` gets a silver chevron. Inputs are deep green-black with an emerald focus ring.
- **Tables:** `<div class="table-wrap"><table class="table table-stack">` and add `data-label="Amount"` to each `<td>`. Under 720px, each row becomes a stacked card. If JS builds the rows, add `data-label` in the template string; that is markup, not logic. Without `.table-stack`, add `.scroll` to `.table-wrap` to scroll sideways instead.
- **Badges:** `.badge` + `-red` (emerald tint, legacy name) `|-solid|-success|-warning|-danger|-muted|-white`.
- **Alerts:** `.alert` + `-error|-success|-info|-warning` (`.msg-error/.msg-success` still work).
- **Modal:** `.modal-overlay#id > .modal-card` (first `<i>` becomes an emerald icon tile, a chrome hairline crowns the card, `.modal-btns` stacks the buttons). Hidden by default. JS `style.display='flex'` or `.is-open` shows it. It's a bottom sheet on phones and centred from 640px.
- **Empty / loading:** `.empty-state` (an `<i>` inside), `.skeleton`.
- **Page furniture:** `.page-header`, `.back-btn`, `.page-title`, `.page-sub`, `.section-head`, `.view-all`, `.divider`.
- **Public pages:** `.topnav > .container.topnav-inner` (`.brand`, `.topnav-links`, `.topnav-cta`, `details.menu-drop` for a JS-free mobile menu), `.site-footer(.dark)`, `.section`, `.section-tint`, `.section-title` (index inline), `.feature-card`, `.plan-card(.is-featured)`, `.step-card`, `.faq-item`.
- **Auth:** `.auth-shell > .container > .auth-card(.wide) > .auth-head(img + h1 + p)`, `.auth-foot`, `.trust-row`.
- **Admin:** dark gradient sidebar with an emerald glow; the active `.side-link` gets an emerald wash and a glowing left bar. `.sidebar` / `.drawer` slide in with `.is-open` (`.active` / `.open` also work for existing JS). `.drawer-backdrop`. Links: `.side-link(.active)`, group labels `.side-label`. From 1024px, use `.sidebar.is-static` + `<main class="with-sidebar">` for a fixed sidebar. Use `.table-wrap/.table-stack` for data and `.stat-card` for KPIs.
- **Motion:** `.fade-up` with `.d1`–`.d4` stagger and `.lift` hover. All of it is disabled under `prefers-reduced-motion`.

## Converting a page (steps 2 and 3)
1. Leave every `<script>`, element `id`, `name`, `onclick` and the class names JS queries (`querySelector('.x')`, `className = 'x'`) unchanged. Change markup and classes around them only. Before you commit, diff the script blocks against `HEAD` (they must be byte-identical) and compare the id sets.
2. Swap the `<head>` for the template above and delete the old `:root` + dark inline `<style>`. Keep only small layout rules that the system lacks.
3. Wrap the page in the app shell, then map old blocks to components: wallet/summary → `.card-hero`, metrics → `.stat-card`, panels/forms → `.card`, lists → `.list-item`, tables → `.table-stack`.
4. Remove hard-coded colours from inline `style=""` attributes (reds, blues, gold, `#229ED9`). Use tokens or utility classes (`.text-success`, `.text-danger`, `.muted`).
5. Check at 390px and 1280px: no horizontal scroll, no clipped numbers, and the bottom nav doesn't cover content.

`top.css` ends with a small **legacy bridge** (`.glass-card`, `.btn-gold`, `.text-gold`, …) that keeps older class names on the emerald theme. The old standalone sheets (`style.css`, `dashboard.css`, `auth.css`, `admin.css`) are not linked by any page; their colours were moved to the emerald/black palette so nothing blue or red remains if one is ever loaded.
