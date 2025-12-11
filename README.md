# Belajar Supabase

Project ini adalah contoh implementasi Vue 3 dengan Supabase, mencakup setup database, autentikasi, dan operasi CRUD sederhana.

## Panduan Setup Supabase

Ikuti langkah-langkah berikut untuk mengatur backend Supabase dari awal.

### 1. Setup Supabase CLI

Install Supabase CLI sebagai dependency dev di project Anda:

```bash
npm install supabase --save-dev
```

### 2. Login ke Supabase

Login menggunakan akun Supabase Anda:

```bash
npx supabase login
```

### 3. Initialize Supabase

Inisialisasi konfigurasi Supabase di project lokal (jika belum):

```bash
npx supabase init
```

### 4. Membuat Migration

Buat file migrasi baru untuk skema database Anda:

```bash
npx supabase migration new buat_table_todo
```

Setelah file dibuat di `supabase/migrations/`, isi dengan SQL query Anda. Contoh untuk tabel `todos`:

```sql
create table todos (
    id serial primary key,
    title text not null,
    is_completed boolean default false,
    created_at timestamp with time zone default now()
);
```

### 5. Link Project

Hubungkan project lokal dengan project di dashboard Supabase. Anda bisa mendapatkan `project-ref` dari URL dashboard Supabase (`https://supabase.com/dashboard/project/<project-ref>`).

```bash
npx supabase link --project-ref <your-project-ref>
```

### 6. Push Database ke Supabase

Push migrasi lokal Anda ke database remote Supabase:

```bash
npx supabase db push
```

### 7. Generate Type Definition

Generate tipe TypeScript dari schema database Anda untuk type safety. Sesuaikan path output sesuai struktur project Anda (contoh di sini ke `src/types/todo.ts`):

```bash
npx supabase gen types typescript --linked > src/types/todo.ts
```

### 8. Implementasi di Vue

Gunakan tipe yang sudah digenerate di dalam komponen Vue Anda.

Contoh `src/lib/supabase.ts` (Client Initialization):

```typescript
import { createClient } from '@supabase/supabase-js'

const supabaseUrl = import.meta.env.VITE_SUPABASE_URL
const supabaseAnonKey = import.meta.env.VITE_SUPABASE_ANON_KEY

export const supabase = createClient(supabaseUrl, supabaseAnonKey)
```

Contoh Penggunaan di Component:

```typescript
import type { Database } from '@/types/todo'

type Todo = Database['public']['Tables']['todos']['Row']

// Gunakan tipe Todo untuk state atau prop
const todos = ref<Todo[]>([])
```
