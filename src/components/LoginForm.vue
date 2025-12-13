<script setup lang="ts">
import { ref, type HTMLAttributes } from "vue"
import { cn } from '@/lib/utils'
import { Button } from '@/components/ui/button'
import {
  Card,
  CardContent,
  CardDescription,
  CardHeader,
  CardTitle,
} from '@/components/ui/card'
import {
  Field,
  FieldDescription,
  FieldGroup,
  FieldLabel,
} from '@/components/ui/field'
import { Input } from '@/components/ui/input'
import { supabase } from "@/lib/supabase"

const props = defineProps<{
  class?: HTMLAttributes["class"]
}>()

const email = ref('')
const password = ref('')
const loading = ref(false)

const handleRegister = async () => {
  try {
    loading.value = true
    const { error } = await supabase.auth.signUp({
      email: email.value,
      password: password.value,
      options: {
        data: {
          name: 'John Doe',
          gender: 'male',
        },
      },
    })
    if (error) throw error
    alert('Check your email for the login link!')
  } catch (error) {
    if (error instanceof Error) {
      alert(error.message)
    }
  } finally {
    loading.value = false
  }
}

const handleLogin = async () => {
  try {
    loading.value = true
    const { error } = await supabase.auth.signInWithPassword({
      email: email.value,
      password: password.value,
    })
    if (error) throw error
    alert('Login successful!')
  } catch (error) {
    if (error instanceof Error) {
      alert(error.message)
    }
  } finally {
    loading.value = false
  }
}
</script>

<template>
  <div :class="cn('flex flex-col gap-6', props.class)">
    <Card>
      <CardHeader>
        <CardTitle>Login to your account</CardTitle>
        <CardDescription>
          Enter your email below to login to your account
        </CardDescription>
      </CardHeader>
      <CardContent>
        <form :disabled="loading">
          <FieldGroup>
            <Field>
              <FieldLabel for="email">
                Email
              </FieldLabel>
              <Input id="email" type="email" placeholder="m@example.com" required v-model="email" />
            </Field>
            <Field>
              <div class="flex items-center">
                <FieldLabel for="password">
                  Password
                </FieldLabel>
                <a href="#" class="ml-auto inline-block text-sm underline-offset-4 hover:underline">
                  Forgot your password?
                </a>
              </div>
              <Input id="password" type="password" required v-model="password" />
            </Field>
            <Field>
              <Button @click.prevent="handleLogin" :disabled="loading">
                Login
              </Button>
              <Button @click.prevent="handleRegister" variant="outline" :disabled="loading">
                Register
              </Button>
              <FieldDescription class="text-center">
                Don't have an account?
                <a href="#">
                  Sign up
                </a>
              </FieldDescription>
            </Field>
          </FieldGroup>
        </form>
      </CardContent>
    </Card>
  </div>
</template>
