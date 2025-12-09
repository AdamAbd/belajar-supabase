<script setup lang="ts">
// Import client yang sudah dibuat
import { supabase } from '@/lib/supabase'
import { ref, onMounted } from 'vue'

interface Todo {
    id: number
    task: string
    is_complete: boolean
    created_at: string
}

const newTodo = ref('')
const todos = ref<Todo[]>([])

const getTodos = async () => {
    // Select * from todos order by created_at desc
    const { data, error } = await supabase
        .from('todos')
        .select('*')
        .order('created_at', { ascending: false })

    if (error) {
        console.error('Error fetching todos:', error)
    } else {
        todos.value = data
    }
}

const addTodo = async () => {
    if (newTodo.value.trim() === '') {
        return
    }

    const { data, error } = await supabase
        .from('todos')
        .insert({ task: newTodo.value })

    if (error) {
        console.error('Error adding todo:', error)
    } else {
        newTodo.value = ''
        getTodos()
    }
}

const toggleStatus = async (todo: Todo) => {
    const { error } = await supabase
        .from('todos')
        .update({ is_complete: todo.is_complete })
        .eq('id', todo.id) // Filter: WHERE id = todo.id

    if (error) {
        console.error('Error updating todo:', error)
    } else {
        // Update state lokal
        // todo.is_complete = todo.is_complete
        getTodos()
    }
}

const deleteTodo = async (id: number) => {
    const { error } = await supabase
        .from('todos')
        .delete()
        .eq('id', id)

    if (error) {
        console.error('Error deleting todo:', error)
    } else {
        // Hapus dari state lokal
        // todos.value = todos.value.filter(t => t.id !== id)
        getTodos()
    }
}

// Panggil saat komponen di-mount
onMounted(() => {
    getTodos()
})
</script>

<template>
    <div>
        <!-- input todo -->
        <div>
            <input v-model="newTodo" @keyup.enter="addTodo" placeholder="Add new todo" />
            <button @click="addTodo">Add</button>
        </div>
        <h1>Todo List</h1>
        <ul>
            <li v-for="todo in todos" :key="todo.id">
                {{ todo.task }}
                <!-- checkbox to update status -->
                <input type="checkbox" v-model="todo.is_complete" @change="toggleStatus(todo)" />
                <!-- delete button -->
                <button @click="deleteTodo(todo.id)">Delete</button>
            </li>
        </ul>
    </div>
</template>