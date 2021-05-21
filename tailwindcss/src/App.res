@module("./logo.svg") external logo: string = "default"

%%raw(`import './App.css';`)

@react.component
let make = () => {
  <div className="p-40 container mx-auto">
    <figure className="md:flex bg-gray-100 rounded-xl p-8 md:p-0 overflow-hidden">
      <img
        className="w-32 h-32 md:w-48 md:h-auto md:rounded-none rounded-full mx-auto"
        src="https://tailwindcss.com/_next/static/media/sarah-dayan.a8ff3f1095a58085a82e3bb6aab12eb2.jpg"
        alt="Sarah Dayan"
        width="384"
        height="512"
      >
      </img>
      <div className="pt-6 md:p-8 text-center md:text-left space-y-4">
        <blockquote>
          <p className="text-lg font-semibold">
            {React.string(`
              “Tailwind CSS is the only framework that I've seen scale
              on large teams. It’s easy to customize, adapts to any design,
              and the build size is tiny.”
            `)}
          </p>
        </blockquote>
        <figcaption className="font-medium">
          <div className="text-cyan-600">
          {React.string("Sarah Dayan")}
          </div>
          <div className="text-gray-500">
          {React.string("Staff Engineer, Algolia")}
          </div>
        </figcaption>
      </div>
    </figure>

  </div>
}
